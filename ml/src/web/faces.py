from flask import Flask, jsonify, make_response, request, abort, redirect, send_file
import logging, os

import emotion_gender_processor as eg_processor

port = int(os.environ.get("PORT", 8084))

app = Flask(__name__)

@app.route('/')
def index():
    return redirect("https://ekholabs.ai", code=302)

@app.route('/classifyImage', methods=['POST'])
def upload():
    try:
        image = request.files['image'].read()
        res = eg_processor.process_image(image)
        return make_response(jsonify({'status': res}), 200)
        # return send_file('/ekholabs/face-classifier/result/predicted_image.png', mimetype='image/png')
    except Exception as err:
        logging.error('An error has occurred whilst processing the file: "{0}"'.format(err))
        abort(400)

@app.errorhandler(400)
def bad_request(erro):
    return make_response(jsonify({'error': 'We cannot process the file sent in the request.'}), 400)

@app.errorhandler(404)
def not_found(error):
    return make_response(jsonify({'error': 'Resource not found.'}), 404)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=port)
