// accepts a list of 20 integers where 1 denotes yes and 0 denotes no
// returns an integer <= 20. Greater the integer, higher is the chance of autism

int autism_index(List<int> answers) {
  int positives = 0;
  for (int i = 0; i < answers.length; i++) {
    if (i == 1 || i == 2 || i == 5 || i == 12) {
      if (answers[i] == 1) {
        positives += 1;
      }
    } else {
      if (answers[i] == 0) {
        positives += 1;
      }
    }
  }
  return positives;
}

bool haveAutisticSigns(List<int> answers, int predictedClassByImage) {
  bool a = (autism_index(answers) / answers.length) > 0.5;
  if (predictedClassByImage == -1) {
    return a;
  }
  bool b = predictedClassByImage == 0;
  return a || b;
}
