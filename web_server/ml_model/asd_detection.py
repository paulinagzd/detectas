import os, sys
from PIL import Image
import numpy as np

from scipy import ndimage
from keras.preprocessing.image import ImageDataGenerator, array_to_img, img_to_array, load_img

# autistic denotes 1, non-autistic denotes 0
def get_data():

    folder = "./datasets/consolidated"
    autistic_folder = folder + "/autistic"
    non_autistic_folder = folder + "/non_autistic"

    autistic_files = [f for f in os.listdir(autistic_folder) if os.path.isfile(os.path.join(autistic_folder, f))]
    non_autistic_files = [f for f in os.listdir(non_autistic_folder) if os.path.isfile(os.path.join(non_autistic_folder, f))]

    print("Working with {0} images of autistic children".format(len(autistic_files)))
    print("Working with {0} images of non autistic children".format(len(non_autistic_files)))

    """
    print("Image examples: ")

    img = Image.open(folder + "/" + onlyfiles[40])

    print(img.format) 
    print(img.size) 
    print(img.mode)
    """

    len_autistic = len(autistic_files)
    len_non_autistic = len(non_autistic_files)
    y_data = []

    for _ in range(len_autistic):
        y_data.append(int(1))

    for _ in range(len_non_autistic):
        y_data.append(int(0))

    dataset = np.ndarray(shape=((len_non_autistic + len_autistic), 224, 224 , 3),
                        dtype=np.float32)

    i = 0
    for _file in autistic_files:
        img = load_img(autistic_folder + "/" + _file)  # this is a PIL image
        img.thumbnail((224, 224))
        # Convert to Numpy Array
        x = img_to_array(img)
        dataset[i] = x
        i += 1
        if i % 250 == 0:
            print("%d images to array" % i)

    for _file in non_autistic_files:
        img = load_img(non_autistic_folder + "/" + _file)  # this is a PIL image
        img.thumbnail((224, 224))
        # Convert to Numpy Array
        x = img_to_array(img)
        dataset[i] = x
        i += 1
        if i % 250 == 0:
            print("%d images to array" % i)

    print("All images to array!")

    print(dataset.shape)
    print(len(y_data))

    return (dataset,y_data)

#get_data()

