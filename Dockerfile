# Use an official Ubuntu base image
FROM ubuntu:20.04

# Set non-interactive frontend for automated installations
ENV DEBIAN_FRONTEND=noninteractive

# Install basic tools and dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    pkg-config \
    libopencv-dev \
    python3 \
    python3-dev \
    python3-pip \
    python3-numpy \
    libgtk-3-dev \
    libcanberra-gtk3-module \
    libtbb-dev \
    libatlas-base-dev \
    gfortran \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev \
    && rm -rf /var/lib/apt/lists/*

# Clone a stable version of OpenCV and OpenCV Contrib
WORKDIR /workspace
RUN git clone -b 4.5.5 https://github.com/opencv/opencv.git
RUN git clone -b 4.5.5 https://github.com/opencv/opencv_contrib.git

# Set up the build directory
WORKDIR /workspace/opencv/build

# Configure the build with CMake, disabling problematic modules
RUN cmake \
    -D CMAKE_BUILD_TYPE=Release \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=/workspace/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON \
    -D BUILD_TESTS=ON \
    -D BUILD_opencv_gapi=OFF \
    -D WITH_TBB=ON \
    -D WITH_V4L=ON \
    -D WITH_QT=OFF \
    -D WITH_OPENGL=ON \
    ..

# Build and install OpenCV with limited threads to avoid memory issues
RUN make -j4 && make install && ldconfig

# Run tests (optional; may still fail for some modules)
RUN make test || echo "Some tests may have failed, check logs for details"

# Clean up source files to reduce image size
WORKDIR /
RUN rm -rf /workspace
