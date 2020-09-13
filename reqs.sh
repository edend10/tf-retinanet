wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b

ENV_NAME=tfr
CONDA_CMD=~/miniconda3/bin/conda
ENV_BIN_DIR=~/miniconda3/envs/${ENV_NAME}/bin
PIP_CMD=${ENV_BIN_DIR}/pip
PY_CMD=${ENV_BIN_DIR}/python

$CONDA_CMD init

$CONDA_CMD -n $ENV_NAME python=3.6 pip -y
$CONDA_CMD install -n $ENV_NAME cudnn=7.6 -y

$PIP_CMD install pillow
$PIP_CMD install opencv-python
$PIP_CMD install pyyaml
$PIP_CMD install dill
$PIP_CMD install numpy
$PIP_CMD install comet_ml
$PIP_CMD install progressbar2
$PIP_CMD install tensorflow
$PY_CMD setup.py build_ext --inplace

$PY_CMD setup.py install --user

