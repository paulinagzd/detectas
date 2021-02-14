from flask import Flask, jsonify, request, redirect, url_for, render_template
import PIL
from PIL import Image
import numpy as np
import ml_model.get_pred as get_pred

app = Flask(__name__)

@app.route('/', methods=['GET'])
def metrics():
    return render_template("index.html")

@app.route("/test", methods=["GET", "POST"])
def test():
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
    # img = Image.open(request.files["file"])
    # c = get_pred.give_prediction(img, "ml_model/facial_model.h5")
    # if c == -1:
    #     desc = "Can't find face. Please retake the image"	

    try:
        img = Image.open(request.files["file"])
        c = get_pred.give_prediction(img, "ml_model/facial_model.h5")
        if c == -1:
            desc = "Can't find face. Please retake the image"
        if c == 2:
            c = -1
            desc = "Server was not able to resize the image into suitable format"
    except PIL.UnidentifiedImageError:
        desc = "Cannot identify image file. Format not supported"
    except Exception as e: 
        print(e)
        desc = str(e)
    # classes = {0: "autistic", 1: "non_autistic", -1: "error_read_description"}
    return jsonify({"route": f"/classify_image", "method": "POST", "class": int(c), "description": desc})

if __name__ == "__main__":
    # get_pred.load_model_from_path("ml_model/facial_model.h5",print_summary=True)
    app.run(debug=True)
