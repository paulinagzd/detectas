from keras.models import load_model
from keras.preprocessing.image import img_to_array, load_img
import numpy as np
import sys

model = load_model('facial_model.h5')
# summarize model.
model.summary()

# dimensions of our images.
img_width, img_height = 150, 150

# Introduce the picture you want to try below.
img = load_img(sys.argv[1],False,target_size=(img_width,img_height))
x = img_to_array(img)
x = np.expand_dims(x, axis=0)
preds = model.predict(x)
print("image:" , int(preds[0][0]))
