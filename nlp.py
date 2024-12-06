from flask import Flask, request, jsonify
from janome.tokenizer import Tokenizer 

app = Flask(__name__)
tokenizer = Tokenizer()

@app.route('/analyze', methods=['POST'])
def analyze():
    text = request.form['question1']
    
    # Janomeで形態素解析
    tokens = [token.surface for token in tokenizer.tokenize(text)]

    # 結果をJSONで返す
    return jsonify({'tokens': tokens})

if __name__ == '__main__':
    app.run(port=5001)
