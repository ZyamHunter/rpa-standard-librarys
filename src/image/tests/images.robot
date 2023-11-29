*** Settings ***
Library     RPA.Images
Library     RPA.FileSystem


*** Tasks ***
Crop Image
    ${IMAGE_PATH}    Absolute Path    src\\image\\assets\\nave.jpg
    # left, top, right, bottom
    Crop Image    image=${IMAGE_PATH}    region=1500, 700, 2900, 2100    filename=${OUTPUT_DIR}${/}CROP_IMAGE.png

Find Template In Image
    ${IMAGE_PATH}    Absolute Path    src\\image\\assets\\nave.jpg
    ${TEMPLATE_PATH}    Absolute Path    ${OUTPUT_DIR}${/}CROP_IMAGE.png
    Find Template In Image    ${IMAGE_PATH}    ${TEMPLATE_PATH}

    # search with region
    ${IMAGE_PATH}    Absolute Path    src\\image\\assets\\nave.jpg
    ${TEMPLATE_PATH}    Absolute Path    ${OUTPUT_DIR}${/}CROP_IMAGE.png
    Find Template In Image    ${IMAGE_PATH}    ${TEMPLATE_PATH}    region=1500, 700, 2900, 2100

# Get Pixel Color In Image
#    ${IMAGE_PATH}    Absolute Path    src\\image\\assets\\nave.jpg
#    ${PIXEL}    Get Pixel Color In Image    image=${IMAGE_PATH}    point=1500, 700

Show Region In Image
    ${IMAGE_PATH}    Absolute Path    src\\image\\assets\\nave.jpg
    ${RESULT}    Show Region In Image    image=${IMAGE_PATH}    region=1500, 700, 2900, 2100    color=blue    width=20
