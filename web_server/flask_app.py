from flask import Flask, jsonify, request
import PIL
from PIL import Image
import numpy as np
import ml_model.get_pred as get_pred

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def index():
	if (request.method == "POST"):
		return jsonify({"route": "/", "method": "POST"}), 201
	else:
		return jsonify({"route": "/", "method": "GET"}), 200

@app.route("/multi/<int:num>", methods=["GET"])
def get_multiply10(num):
	return jsonify({"route": f"/multi/{num}", "method": "GET", "ans": num*10})

# curl -F "file=@image.jpg" http://localhost:5000/
@app.route("/classify_image", methods=["POST"])
def classify_image():
    c = -1
    desc = ""
    try:
        img = Image.open(request.files["file"])
        c = get_pred.give_prediction(img)
        if c == -1:
            desc = "Can't find face. Please retake the image"
    except PIL.UnidentifiedImageError:
        desc = "Cannot identify image file. Format not supported"
    except:
        desc = "Something else went wrong"
    # classes = {0: "autistic", 1: "non_autistic", -1: "error_read_description"}
    return jsonify({"route": f"/classify_image", "method": "POST", "class": int(c), "description": desc})

if __name__ == "__main__":
    get_pred.load_model_from_path("ml_model/facial_model.h5",print_summary=False)
    app.run(debug=True)
