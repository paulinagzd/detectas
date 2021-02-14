# detectas
<img src="https://user-images.githubusercontent.com/31121102/107885350-bb2eae00-6f1f-11eb-9c97-561127360fd9.png" width="200" />
Our app provides an accessible tool for parents to determine if their child (of 2 to 8 years) shows signs of autism and recommends them further resources if necessary.

## Screenshots
<table style="width:100%">
  <tr>
    <td><img src="https://user-images.githubusercontent.com/31121102/107883321-56218b00-6f14-11eb-9e47-bca957a9d8f0.png" width="200" /></td>
    <td><img src="https://user-images.githubusercontent.com/31121102/107883324-5a4da880-6f14-11eb-8041-cd05131ed12f.png" width="200" /></td>
    <td><img src="https://user-images.githubusercontent.com/31121102/107883323-591c7b80-6f14-11eb-8e7c-f9668dafd5cc.png" width="200"/></td>
<td><img src="https://user-images.githubusercontent.com/31121102/107883325-5ae63f00-6f14-11eb-84ea-4096eabdb18e.png" width="200" /></td>
  </tr>
</table>

## Demo Video
https://vimeo.com/512243291

## Repo Info
We used Flutter, Dart to build our UI.  
Our app asks questions (taken from [M-Chat-R Questionnaire](https://drive.google.com/file/d/1cARz8SuwJgXBADow27YGId111q9Y-Sx8/view)).  
Then we also take an image of candidate and pass it through our trained cnn model to predict the resutls.  (Model is in folder detectas/web_server/ml_model/).  
This model is hosted on azure and for more information go to the folder detectas/web_server.

## FAQ
### What is autism
Autism, or autism spectrum disorder (ASD), refers to a broad range of conditions characterized by challenges with social skills, repetitive behaviors, speech and nonverbal communication.
