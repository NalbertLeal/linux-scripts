# TURN NVIDIA REPOSITORY INTI THE PREFERENCE
touch /etc/apt/preferences.d/nvidia-docker-pin-1002
echo "Package: *" >> /etc/apt/preferences.d/nvidia-docker-pin-1002
echo "Pin: origin nvidia.github.io" >> /etc/apt/preferences.d/nvidia-docker-pin-1002
echo "Pin-Priority: 1002" >> /etc/apt/preferences.d/nvidia-docker-pin-1002

# REMOVING CONFLICT
sudo cp /etc/apt/sources.list.d/nvidia-container-toolkit.list /home/$USER/nvidia-container-toolkit.list
sudo rm /etc/apt/sources.list.d/nvidia-container-toolkit.list

# DOWNLOAD GPG KEYS
distribution=$(. /etc/os-release;echo ubuntu20.04) \
        && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
        && curl -s -L https://nvidia.github.io/libnvidia-container/experimental/$distribution/libnvidia-container.list | \
         sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
         sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# INSTALL NVIDIA-CONTAINER-TOOKIT
sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
