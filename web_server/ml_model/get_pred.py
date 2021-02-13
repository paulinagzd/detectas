from keras.models import load_model
from keras.preprocessing.image import img_to_array, load_img
import numpy as np
import sys
import os
from PIL import Image


def load_model_from_path(model_path: str, print_summary:bool=False):
    global model
    model = load_model(model_path)
    # summarize model.
    model.summary()

# dimensions of our images.
img_size = (150, 150) # width, height

def resize_image_square(image: Image, size: (int, int)) -> Image:
    (w0, h0) = size
    w1 = image.size[0]
    h1 = image.size[1]
    rw = w0/w1
    rh = h0/h1
    print(f"{w1} {h1} {rw} {rh}")
    if w1 * rh >= w0:
        # go with height extension
        new_w = int(w1 * rh)
        resized_image = image.resize((new_w, h0), Image.ANTIALIAS)
        required_loss = new_w - w0
        resized_image = resized_image.crop(box=(required_loss / 2, 0, resized_image.size[0] - required_loss / 2, h0))
        return resized_image
    else:
        # go with width extension
        new_h = int(h1 * rw)
        resized_image = image.resize((w0, new_h), Image.ANTIALIAS)
        required_loss = new_h - h0
        resized_image = resized_image.crop(box=(0, required_loss / 2, w0, resized_image.size[1] - required_loss / 2))
        return resized_image

def give_prediction(img: Image) -> int:
    # img.thumbnail((img_width, img_height), Image.ANTIALIAS) # resizing image while maintaining aspect ratio
    img = resize_image_square(img, img_size)
    img = img.convert('RGB') # we might get PNG which has value 4 in 3rd dim. So, need to make sure we convert it to jpg to just 3 layers first
    print(img.size)
    if img.size == img_size:
        img = np.array(img.getdata()).reshape(img.size[0], img.size[1], 3) # converting PIL image to numpy image
        # img = load_img(sys.argv[1],False,target_size=(img_width,img_height))
        x = img_to_array(img)
        x = np.expand_dims(x, axis=0)
        preds = model.predict(x)
        print("image:" , int(preds[0][0]))
        return preds[0][0]
    else:
        print(f"error in server: could not convert image to {img_size}")
        return -1