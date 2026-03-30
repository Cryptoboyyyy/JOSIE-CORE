from flask import Flask, request
import subprocess

app = Flask(__name__)

@app.route('/handshake')
def handshake():
    new_port = request.args.get('port')
    target_ip = "100.66.159.200"
    if new_port:
        print(f"[+] Web-Trigger: Re-binding to {target_ip}:{new_port}")
        subprocess.run(["adb", "connect", f"{target_ip}:{new_port}"])
        subprocess.run(["adb", "-s", f"{target_ip}:{new_port}", "shell", "wm", "density", "411"])
        return f"JOSIE-CORE Linked to {new_port}", 200
    return "Port Missing", 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
