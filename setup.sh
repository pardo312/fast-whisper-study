#!/bin/bash
set -e  # Exit on any error

echo "Creating virtual environment..."
python3.10 -m venv fwenv

echo "Activating virtual environment..."
source fwenv/bin/activate

echo "Upgrading pip..."
pip install --upgrade pip

echo "Installing faster-whisper..."
pip install faster-whisper

sudo apt update

echo "Installing nvidia-cuda..."
sudo apt install nvidia-cuda-toolkit

echo "Installing ffmpeg..."
sudo apt install -y ffmpeg

echo "🎵 IMPORTANT: Make sure you have an 'audio.mp3' file in this directory before proceeding! 🎵"
echo "📁 The test script will look for 'audio.mp3' to transcribe."
echo "⏳ Press Enter when you're ready to run the test, or Ctrl+C to exit..."
read -p "🚀 Ready to test? "

echo "🧪 Running test..."
python3.10 test.py


echo "
En caso de que salga este error: 

--------------------------------------------------
Unable to load any of {libcudnn_ops.so.9.1.0, libcudnn_ops.so.9.1, libcudnn_ops.so.9, libcudnn_ops.so}
Invalid handle. Cannot load symbol cudnnCreateTensorDescriptor
Aborted (core dumped)
--------------------------------------------------

Es necesario descargar cuda: cudnn-linux-x86_64-9.10.2.21_cuda12-archive.tar.xz desde https://developer.nvidia.com/rdp/cudnn-download
y realizar symlinks asi:

# Descomprimir
cd ~/Downloads
tar -xvf cudnn-linux-x86_64-9.10.2.21_cuda12-archive.tar.xz
cd cudnn-linux-x86_64-9.10.2.21_cuda12-archive

# Copiar headers
sudo cp include/* /usr/local/cuda/include/

# Copiar librerías
sudo cp lib/* /usr/local/cuda/lib64/

# Recargar links dinámicos
sudo ldconfig

ls /usr/local/cuda/lib64 | grep cudnn

y finalmente volver a nuestro proyecto (cd /Fast-Whisper) y :
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

Despues ejecutar de nuevo:
python3.10 test.py
"