git clone https://github.com/inogii/AudioLDM-training-finetuning
cd AudioLDM-training-finetuning
bash <(curl -sSL https://g.bodaay.io/hfd) -h
chmod +x hfdownloader
./hfdownloader -d inogii/audiocaps_compressed -c 10 -s /root/AudioLDM-training-finetuning/data/dataset
python merge_chunks.py

./hfdownloader -d inogii/audioldm_checkpoints -c 10 -s /root/AudioLDM-training-finetuning/data/checkpoints

python merge_chunks.py

rm -rf data/dataset/inogii_audiocaps_compressed
unzip data/dataset/reassembled_dataset.zip