# Fast Whisper Study

A comprehensive setup and study project for implementing OpenAI's Whisper speech-to-text model using the faster-whisper library with CUDA acceleration on Windows/Linux systems.

## 📋 Overview

This project provides an automated setup script and testing environment for faster-whisper, a reimplementation of OpenAI's Whisper model using CTranslate2, which offers significant performance improvements over the original implementation.

## 🚀 Features

- **Automated Setup**: One-script installation of all dependencies
- **CUDA Acceleration**: GPU-accelerated transcription for faster processing
- **Multiple Model Sizes**: Support for various Whisper model sizes
- **Audio Format Support**: Works with multiple audio formats via FFmpeg
- **Error Handling**: Comprehensive troubleshooting guide for common issues

## 📁 Project Structure

```
FastWhisper/
├── setup.sh           # Automated installation script
├── test.py            # Audio transcription test script
├── samples/           # Sample audio files for testing
│   └── mom.wav        # Example audio file
├── fwenv/             # Python virtual environment (auto-generated)
├── .gitignore         # Git ignore rules
└── README.md          # This file
```

## 🛠️ System Requirements

### Hardware Requirements
- **GPU**: NVIDIA GPU with CUDA support (recommended)
- **RAM**: Minimum 4GB, 8GB+ recommended for larger models
- **Storage**: At least 2GB free space for models and dependencies

### Software Requirements
- **OS**: Ubuntu 18.04+ / Windows 10+ with WSL2
- **Python**: 3.8 - 3.11 (3.10 recommended)
- **CUDA**: 11.2+ (for GPU acceleration)
- **Git**: For cloning and version control

## 📦 Installation

### Quick Start

1. **Clone the repository**:
   ```bash
   git clone git@github.com:pardo312/fast-whisper-study.git
   cd fast-whisper-study
   ```

2. **Run the setup script**:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

3. **Follow the prompts** and ensure you have an audio file ready for testing.

### Manual Installation

If you prefer manual installation:

1. **Create virtual environment**:
   ```bash
   python3.10 -m venv fwenv
   source fwenv/bin/activate
   ```

2. **Install dependencies**:
   ```bash
   pip install --upgrade pip
   pip install faster-whisper
   ```

3. **Install system dependencies**:
   ```bash
   sudo apt update
   sudo apt install nvidia-cuda-toolkit ffmpeg
   ```

## 🎯 Usage

### Basic Transcription

1. **Activate the virtual environment**:
   ```bash
   source fwenv/bin/activate
   ```

2. **Run the test script**:
   ```bash
   python3.10 test.py
   ```

### Custom Audio Files

To transcribe your own audio files, modify the `test.py` script:

```python
# Replace "samples/mom.wav" with your audio file path
segments, info = model.transcribe("path/to/your/audio.wav", beam_size=5)
```

### Model Configuration

The test script supports different configurations:

```python
# GPU with FP16 (fastest, requires more VRAM)
model = WhisperModel(model_size, device="cuda", compute_type="float16")

# GPU with INT8 (balanced performance/memory)
model = WhisperModel(model_size, device="cuda", compute_type="int8_float16")

# CPU with INT8 (slower but works without GPU)
model = WhisperModel(model_size, device="cpu", compute_type="int8")
```

### Available Model Sizes

- `tiny`: Fastest, least accurate (~39 MB)
- `base`: Good balance (~74 MB)
- `small`: Better accuracy (~244 MB)
- `medium`: High accuracy (~769 MB)
- `large-v3`: Best accuracy (~1550 MB) - **Default**

## 🔧 Troubleshooting

### Common Issues

#### CUDA/cuDNN Error
If you encounter this error:
```
Unable to load any of {libcudnn_ops.so.9.1.0, libcudnn_ops.so.9.1, libcudnn_ops.so.9, libcudnn_ops.so}
Invalid handle. Cannot load symbol cudnnCreateTensorDescriptor
Aborted (core dumped)
```

**Solution**:

1. **Download cuDNN**:
   - Visit [NVIDIA cuDNN Download](https://developer.nvidia.com/rdp/cudnn-download)
   - Download: `cudnn-linux-x86_64-9.10.2.21_cuda12-archive.tar.xz`

2. **Install cuDNN**:
   ```bash
   cd ~/Downloads
   tar -xvf cudnn-linux-x86_64-9.10.2.21_cuda12-archive.tar.xz
   cd cudnn-linux-x86_64-9.10.2.21_cuda12-archive
   
   # Copy headers
   sudo cp include/* /usr/local/cuda/include/
   
   # Copy libraries
   sudo cp lib/* /usr/local/cuda/lib64/
   
   # Reload dynamic links
   sudo ldconfig
   ```

3. **Verify installation**:
   ```bash
   ls /usr/local/cuda/lib64 | grep cudnn
   ```

4. **Set environment variable**:
   ```bash
   export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
   ```

5. **Test again**:
   ```bash
   python3.10 test.py
   ```

#### Memory Issues
- Use smaller model sizes (`base` or `small`)
- Switch to CPU processing if GPU memory is insufficient
- Close other GPU-intensive applications

#### Audio Format Issues
- Ensure FFmpeg is properly installed
- Convert audio to supported formats (WAV, MP3, FLAC)
- Check audio file permissions

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- [OpenAI Whisper](https://github.com/openai/whisper) - Original Whisper implementation
- [faster-whisper](https://github.com/guillaumekln/faster-whisper) - Optimized implementation
- [CTranslate2](https://github.com/OpenNMT/CTranslate2) - Fast inference engine

## 📚 Additional Resources

- [Whisper Paper](https://arxiv.org/abs/2212.04356)
- [faster-whisper Documentation](https://github.com/guillaumekln/faster-whisper)
- [CUDA Installation Guide](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/)
- [cuDNN Installation Guide](https://docs.nvidia.com/deeplearning/cudnn/install-guide/)

---

**Note**: This project is for educational and research purposes. Make sure to comply with audio transcription laws and regulations in your jurisdiction.
