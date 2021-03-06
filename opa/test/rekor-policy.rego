package k8srekorverify

violation[{"msg": msg, "details": {}}] {
    image := input_containers[_].image
    not has_image_tag with input as image
    msg := sprintf("\nImage: %v requires a tag", [image])
} 

violation[{"msg": msg, "details": {}}] {
    image := input_containers[_].image
    # NOTE: if we don't have an image tag, then this violation will not 
    # apply, and the other violation will trigger instead to give a more
    # meaningful message
    has_image_tag with input as image
    
    split_image := split(image,":")
    image_tag := split_image[count(split_image)-1]

    rekor_url := sprintf("%v/api/v1/log/entries/%v", [input.parameters.rekorServerURL, image_tag])
    http.send({"method": "get", "url": rekor_url}, output) 

    output.status_code != 200
    msg := sprintf("\nImage: %v\nStatus code: %v \nBody: %v\n", [image, output.status_code, output.body])
} 

has_image_tag {
  count(split(input,":")) > 1
}

input_containers[c] {
    c := input.review.object.spec.containers[_]
}

input_containers[c] {
    c := input.review.object.spec.initContainers[_]
}