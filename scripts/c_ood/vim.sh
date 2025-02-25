#!/bin/bash
# sh scripts/c_ood/0_mnist_test_fsood_msp.sh

GPU=1
CPU=1
node=73
jobname=openood

PYTHONPATH='.':$PYTHONPATH \
srun -p mediasuper -x SZ-IDC1-10-112-2-17 --gres=gpu:${GPU} \
--cpus-per-task=${CPU} --ntasks-per-node=${GPU} \
--kill-on-bad-exit=1 --job-name=${jobname} \
python main.py \
--config configs/datasets/imagenet/imagenet.yml \
configs/datasets/imagenet/imagenet_ood.yml \
configs/networks/vit.yml \
configs/pipelines/test/test_ood.yml \
configs/postprocessors/vim.yml \
--num_workers 4 \
--network.checkpoint ./checkpoints/vit-base-p16_in21k-pre-3rdparty_ft-64xb64_in1k-384_20210928-98e8652b.pth \
--mark 0
