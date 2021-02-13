from flask import Flask, jsonify, request
from PIL import Image
import numpy as np

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

	# TODO: add a try catch block here

    # img = Image.open(request.files["file"])
    # # print(img.size)
    # numpy_img = np.array(img.getdata()).reshape(img.size[0], img.size[1], 3)
    # print(numpy_img.shape)
    # print(numpy_img)
    # classes = {0: "autistic", 1: "non_autistic", -1: "error_read_description"}
    print(request.files)
    return jsonify({"route": f"/classify_image", "method": "POST", "class": -1, "description": "Can't find face. Please recapture the image"})

if __name__ == "__main__":
    app.run(debug=True)
