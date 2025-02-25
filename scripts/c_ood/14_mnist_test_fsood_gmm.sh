#!/bin/bash
# sh scripts/c_ood/14_mnist_test_fsood_gmm.sh

GPU=1
CPU=1
node=73
jobname=openood

PYTHONPATH='.':$PYTHONPATH \
srun -p dsta --mpi=pmi2 --gres=gpu:${GPU} -n1 \
--cpus-per-task=${CPU} --ntasks-per-node=${GPU} \
--kill-on-bad-exit=1 --job-name=${jobname} -w SG-IDC1-10-51-2-${node} \
python main.py \
--config configs/datasets/digits/mnist.yml \
configs/datasets/digits/mnist_fsood.yml \
configs/networks/lenet.yml \
configs/pipelines/test/test_fsood.yml \
configs/postprocessors/gmm.yml \
configs/preprocessors/base_preprocessor.yml \
--num_workers 8 \
--network.checkpoint ./results/mnist_lenet_base_e100_lr0.1/best_epoch91_acc0.9950.ckpt \
--mark 0
