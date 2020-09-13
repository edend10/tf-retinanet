DATASET_NAME=$1
EPOCHS=$2
STEPS=$3
COMET_API_KEY=$4

# train
python tf_retinanet/bin/train.py --config conf/${DATASET_NAME}.yaml --freeze-backbone \
    --random-transform \
    --batch-size 8 \
    --steps $STEPS \
    --epochs $EPOCHS \
    --comet-ws edolev89 \
    --comet-tags ds:${DATASET_NAME}

COMET_EXPERIMENT_KEY=$(cat /tmp/comet_exp_key.txt)

echo '' > eval_logs.txt
for i in $(seq 10 5 $EPOCHS); do
    echo "--${i}--"

    python tf_retinanet/bin/convert_model.py results/${DATASET_NAME}/snapshots_train/tf_retinanet/${i}.h5 results/${DATASET_NAME}/saved_models/1 --config conf/${DATASET_NAME}.yaml

    echo "--${i}--" >> eval_logs.txt

    python tf_retinanet/bin/evaluate.py --save-path=results/${DATASET_NAME}/test_results --config=conf/${DATASET_NAME}.yaml | grep mAP: >> eval_logs.txt
done
