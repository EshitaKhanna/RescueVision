from fastapi import FastAPI, File, UploadFile
from fastapi.responses import Response, StreamingResponse
from model import VideoProcessor
import io

app = FastAPI()
video_processor = VideoProcessor(model_path='net/trained_models/its_train.pk')

@app.post("/dehaze-video")
async def dehaze_video(video: UploadFile = File(...)):
    try:
        video_bytes = await video.read()
        processed_video = video_processor.process_video(video_bytes)

        return StreamingResponse(
            io.BytesIO(processed_video),
            media_type="video/mp4",
            headers={
                'Content-Disposition': 'attachment;filename=dehazed_video.mp4'
            }
        )
    except Exception as e:
        return {"error": str(e)}
