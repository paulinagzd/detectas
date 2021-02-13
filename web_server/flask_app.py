from flask import Flask, jsonify, request

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

if __name__ == "__main__":
    app.run(debug=True)
