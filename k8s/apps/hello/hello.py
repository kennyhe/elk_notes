from flask import Flask
from flask import request
import json

app = Flask(__name__)

@app.route('/data', methods=['GET'])
def read_file():
  content = ''
  with open('data.txt') as file:
    content = file.read()
  return content

@app.route('/data', methods=['POST'])
def append_row():
  line = request.data.decode('utf-8')
  if line:
    with open('data.txt', 'a') as file:
      file.write(line)
      file.write('\n')
      return json.dumps({'success':True}), 200, {'ContentType':'application/json'}
  return json.dumps({'success':False}), 500, {'ContentType':'application/json'}

if __name__ == "__main__": 
    app.run(host ='0.0.0.0', port = 5000, debug = False)  
