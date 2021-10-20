# Data import


from sklearn.ensemble import RandomForestClassifier
import matplotlib.pyplot as plt
from sklearn.metrics import roc_curve
from sklearn.metrics import accuracy_score
from sklearn.model_selection import GridSearchCV
from sklearn.model_selection import cross_val_score
from sklearn.metrics import confusion_matrix
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import train_test_split
from feature_engine.encoding import OneHotEncoder as OHE
from sklearn.preprocessing import StandardScaler
import pandas as pd
import numpy as np

df = pd.read_csv(
    "BankChurners v5.csv")
df = df.drop(df.columns[0], axis=1)
X = df.drop(df.columns[0], axis=1)
Y = df[df.columns[0]].astype('int')

X_float = X.select_dtypes(np.unique(X.dtypes)[0:2])
X_str = X.select_dtypes(np.unique(X.dtypes)[2])

print(X_float.shape)
print(X_str.shape)

# Standardization


scaler = StandardScaler()
scaler.fit(X_float)
X_float = pd.DataFrame(scaler.transform(X_float), columns=X_float.columns)

# Categorical Data

for col in X_str.columns:
    print(col, len(X_str[col].unique()))


dummy_model = OHE(variables=X_str.columns.tolist(),
                  drop_last=False)
dummy_model.fit(X_str)
X_dummy = dummy_model.transform(X_str)
X_dummy.reset_index(inplace=True)
X_dummy = X_dummy.drop(X_dummy.columns[0], axis=1)
X = pd.concat([X_float, X_dummy], axis=1)

print(X.shape)
X.isnull().sum(axis=0).sum()

# Decision tree

X_train, X_test, Y_train, Y_test = train_test_split(
    X.values, Y.values, test_size=0.3)

modeldt = DecisionTreeClassifier(max_depth=6, min_samples_split=2)
modeldt.fit(X_train, Y_train)

preddt1 = modeldt.predict(X_train)
train_cm = confusion_matrix(Y_train, preddt1)
print(train_cm)
train_accuracy = (train_cm[0, 0]+train_cm[1, 1])/sum(sum(train_cm))
print(train_accuracy)
# 0.9518716577540107

preddt2 = modeldt.predict(X_test)
test_cm = confusion_matrix(Y_test, preddt2)
print(test_cm)
test_accuracy = (test_cm[0, 0]+test_cm[1, 1])/sum(sum(test_cm))
print(test_accuracy)
# 0.8981288981288982

print(cross_val_score(modeldt, X_train, Y_train, scoring="accuracy", cv=5).mean())
# 0.8948228205536111

# Hyperparameter Optimize


modeldt = DecisionTreeClassifier()

param_grid = {
    'max_depth': np.arange(1, 100, 1, dtype=int),
    'min_samples_split': np.arange(2, 100, 1, dtype=int),
}
grid_reg = GridSearchCV(modeldt, param_grid=param_grid,
                        cv=5, refit=True, return_train_score=True)

grid_reg.fit(X_train, Y_train)
scores_df = pd.DataFrame(grid_reg.cv_results_)

print(grid_reg.best_estimator_)
# Final Output: DecisionTreeClassifier(max_depth=7, min_samples_split=3)

modeldt = DecisionTreeClassifier(max_depth=7, min_samples_split=3)
modeldt.fit(X_train, Y_train)
print(cross_val_score(modeldt, X_train, Y_train, scoring="accuracy", cv=5).mean())
# 0.901511294941139

preddt3 = modeldt.predict(X_test)
test_cm = confusion_matrix(Y_test, preddt3)
test_accuracy = (test_cm[0, 0]+test_cm[1, 1])/sum(sum(test_cm))
print(test_accuracy)
# 0.9054054054054054


fpr, tpr, thresholds = roc_curve(Y_test, preddt3)
plt.plot(fpr, tpr)
plt.show()

# Variable Importance

fr = modeldt.feature_importances_
print(fr)

# Plot decision tree

plt.subplots(figsize=(20, 10))
tree.plot_tree(modeldt, fontsize=10)


# Random Forest

modelrf = RandomForestClassifier(
    n_estimators=10, max_depth=7, min_samples_split=3)
modelrf.fit(X_train, Y_train)

predrf1 = modelrf.predict(X_train)
train_cm = confusion_matrix(Y_train, predrf1)
print(train_cm)
train_accuracy = (train_cm[0, 0]+train_cm[1, 1])/sum(sum(train_cm))
print(train_accuracy)
# 0.9590017825311943

predrf2 = modelrf.predict(X_test)
test_cm = confusion_matrix(Y_test, predrf2)
print(test_cm)
test_accuracy = (test_cm[0, 0]+test_cm[1, 1])/sum(sum(test_cm))
print(test_accuracy)
# 0.9085239085239085

print(cross_val_score(modelrf, X_train, Y_train, scoring="accuracy", cv=5).mean())
# 0.9068584950684059

# Hyperparameter Optimize

modelrf = RandomForestClassifier()

param_grid = {
    'n_estimators': np.arange(5, 20, 5, dtype=int),
    'max_depth': np.arange(1, 20, 1, dtype=int),
    'min_samples_split': np.arange(2, 20, 1, dtype=int),
}
grid_reg = GridSearchCV(modelrf, param_grid=param_grid,
                        cv=5, refit=True, return_train_score=True)

grid_reg.fit(X_train, Y_train)
scores_df = pd.DataFrame(grid_reg.cv_results_)

print(grid_reg.best_estimator_)
# Final Output: RandomForestClassifier(max_depth=19, min_samples_split=15, n_estimators=15)

modelrf = RandomForestClassifier(
    max_depth=19, min_samples_split=15, n_estimators=15)
modelrf.fit(X_train, Y_train)
print(cross_val_score(modelrf, X_train, Y_train, scoring="accuracy", cv=5).mean())
# 0.9135459751829462

predrf3 = modelrf.predict(X_test)
test_cm = confusion_matrix(Y_test, predrf3)
test_accuracy = (test_cm[0, 0]+test_cm[1, 1])/sum(sum(test_cm))
print(test_accuracy)
# 0.9303534303534303

fpr, tpr, thresholds = roc_curve(Y_test, predrf3)
plt.plot(fpr, tpr)
plt.show()

# Variable Importance

fr1 = modelrf.feature_importances_
print(fr1)
