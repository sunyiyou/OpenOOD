#!/bin/bash
# sh scripts/0_basics/mnist_test.sh

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
configs/networks/lenet.yml \
configs/pipelines/test/test_acc.yml \
--dataset.image_size 28 \
--network.name lenet \
--network.checkpoint ./results/mnist_lenet_base_e100_lr0.1/best.ckpt \
--num_workers 4
