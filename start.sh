docker run  -ti --rm \
            --runtime=nvidia \
            -v $PWD/../../data:/embclip-habitat/data \
            -v $PWD/pretrained_models:/embclip-habitat/pretrained_models \
            embclip bash