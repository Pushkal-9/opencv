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
