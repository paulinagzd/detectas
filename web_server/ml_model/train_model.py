from keras.preprocessing.image import ImageDataGenerator
from keras.models import Sequential
from keras.layers import Conv2D, MaxPooling2D
from keras.layers import Activation, Dropout, Flatten, Dense
from keras.models import Model
from keras import backend as K
import os
import torch

device = torch.device('cuda') if torch.cuda.is_available() else torch.device('cpu')
print(device)

# dimensions of our images.
img_width, img_height = 150, 150

train_data_dir = './datasets/train'
validation_data_dir = './datasets/valid'
nb_train_samples = sum([len(files) for r, d, files in os.walk(train_data_dir)])
nb_validation_samples = sum([len(files) for r, d, files in os.walk(validation_data_dir)])
epochs = 50
batch_size = 100

print('no. of trained samples = ', nb_train_samples, ' no. of validation samples = ',nb_validation_samples)

# this is the augmentation configuration we will use for training
train_datagen = ImageDataGenerator(
    rescale=1. / 255,
    shear_range=0.2,
    zoom_range=0.2,
    horizontal_flip=True)

# this is the augmentation configuration we will use for testing:
# only rescaling
test_datagen = ImageDataGenerator(rescale=1. / 255)

train_generator = train_datagen.flow_from_directory(
    train_data_dir,
    target_size=(img_width, img_height),
    batch_size=batch_size,
    class_mode='binary')

validation_generator = test_datagen.flow_from_directory(
    validation_data_dir,
    target_size=(img_width, img_height),
    batch_size=batch_size,
    class_mode='binary')

#from keras.applications.vgg19 import VGG19

model = Sequential()
print(type(model))

model.add(Conv2D(32, (3, 3), input_shape=(img_width,img_height,3)))
model.add(Activation('relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))

model.add(Conv2D(32, (3, 3)))
model.add(Activation('relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))

model.add(Conv2D(64, (3, 3)))
model.add(Activation('relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))

#model = ResNet50(include_top=False, input_shape=(img_width, img_height, 3))

model.add(Flatten())
model.add(Dense(64))
model.add(Activation('relu'))
model.add(Dropout(0.5))
model.add(Dense(1))
model.add(Activation('sigmoid'))

model.compile(
        loss='binary_crossentropy',
        optimizer='rmsprop',
        metrics=['accuracy'])

"""
# load model without classifier layers
model = VGG19(include_top=False, input_shape=(img_width, img_height, 3))
# add new classifier layers
flat1 = Flatten()(model.layers[-1].output)
class1 = Dense(1024, activation='relu')(flat1)
output = Dense(1, activation='softmax')(class1)
# define new model
model = Model(inputs=model.inputs, outputs=output)
# summarize
model.summary()

model.compile(
        loss='binary_crossentropy',
        optimizer='rmsprop',
        metrics=['accuracy'])
"""
        
model.fit(
    train_generator,
    steps_per_epoch=nb_train_samples // batch_size,
    epochs=epochs,
    validation_data=validation_generator,
    validation_steps=nb_validation_samples // batch_size)

loss, accuracy = model.evaluate(validation_generator)
print("Test: accuracy = %f  ;  loss = %f " % (accuracy, loss))

model.save("facial_model.h5")
print("Saved model to disk")
