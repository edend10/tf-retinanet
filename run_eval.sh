DATASET_NAME=ds1

echo '' > eval_logs.txt
for i in $(seq 10 5 80); do
    echo "--${i}--"

    python tf_retinanet/bin/convert_model.py results/${DATASET_NAME}/snapshots_train/tf_retinanet/${i}.h5 results/${DATASET_NAME}/saved_models/1 --config conf/${DATASET_NAME}.yaml

    echo "--${i}--" >> eval_logs.txt

    python tf_retinanet/bin/evaluate.py --save-path=results/${DATASET_NAME}/test_results --config=conf/${DATASET_NAME}.yaml | grep mAP: >> eval_logs.txt
done
