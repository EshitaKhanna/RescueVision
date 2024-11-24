from fastapi import FastAPI, File, UploadFile
from fastapi.responses import Response
from model import VideoProcessor  # Import from model.py instead of utils.py

app = FastAPI()

# Initialize the video processor with the path to your pretrained model
video_processor = VideoProcessor(model_path='net/trained_models/its_train.pk')

@app.post("/dehaze-video")
async def dehaze_video(video: UploadFile = File(...)):
    video_bytes = await video.read()

    try:
        processed_video = video_processor.process_video(video_bytes)
        return Response(content=processed_video, media_type="video/mp4")
    except Exception as e:
        return {"error": str(e)}
