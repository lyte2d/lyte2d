docker run  -it --rm --name=builder \
    	    --mount type=bind,source=${PWD},target=/src \
		    --workdir /src \
    	    -t "more/builder:latest" \
            bash
