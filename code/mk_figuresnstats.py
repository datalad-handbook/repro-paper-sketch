#!/usr/bin/env python


import pandas as pd
import seaborn as sns
import datalad.api as dl
from sklearn import model_selection
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import classification_report


# global variables
data = "input/iris.csv"

def read_data(data):
    """
    Get and read in data.
    """
    dl.get(data)
    df = pd.read_csv(data)
    attributes = ["sepal_length", "sepal_width", "petal_length", "petal_width",
                  "class"]
    df.columns = attributes
    return df


def plot_relationships(df):
    """
    Create a pairplot to plot pairwise relationships in the dataset and save the
    results as png file
    :param df: pandas dataframe
    """
    plot = sns.pairplot(df, hue='class', palette='muted')
    plot.savefig('img/pairwise_relationships.png')


def knn(df):
    """
    Perform a K-nearest-neighbours classification with scikit-learn and save the
    results as a csv file
    :param df: pandas dataframe
    """
    array = df.values
    X = array[:, 0:4]
    Y = array[:, 4]
    test_size = 0.20
    seed = 7
    X_train, X_test, Y_train, Y_test = model_selection.train_test_split(X, Y,
                                                                        test_size=test_size,
                                                                        random_state=seed)
    # Step 2: Fit the model and make predictions on the test dataset
    knn = KNeighborsClassifier()
    knn.fit(X_train, Y_train)
    predictions = knn.predict(X_test)

    # Step 3: Save the classification report
    report = classification_report(Y_test, predictions, output_dict=True)
    df_report = pd.DataFrame(report).transpose().to_csv('prediction_report.csv',
                                                        float_format='%.2f')
    return report


def print_prediction_report(report):
    """
    Print out items from the prediction report as LaTeX variables.
    Those printed variables can later be collected in a .tex file
    and embedded into a manuscript.
    :param report: dict; sklearn classification report
    """

    for key, labelprefix in [('Setosa', 'Setosa'),
                             ('Versicolor', 'Versicolor'),
                             ('Virginica', 'Virginica'),
                             ('macro avg', 'MA'),
                             ('weighted avg', 'WA')
                             ]:
        for var, varprefix in [('precision', 'Precision'),
                               ('recall', 'Recall'),
                               ('f1-score', 'F'),
                               ('support', 'Support')]:
            # round to two floating points
            format = "%.2f"
            score = report[key][var]
            label = str(labelprefix + varprefix)
            print('\\newcommand{\\%s}{%s}' % (label, format % score))
    # also print accuracy
    acc = report['accuracy']
    print('\\newcommand{\\accuracy}{%s}' % (acc))


def main(data):
    # get and load the data
    df = read_data(data)
    # create a plot
    plot_relationships(df)
    # train, predict, evaluate, and save results of KNN classification
    report = knn(df)
    # print variables
    print_prediction_report(report)

if __name__ == '__main__':
    main(data)
