# Project-1
Detecting Cancer in Breast Cells (15 points)
In this problem, you will build a set of different models to diagnose breast cancer. Images as the one
shown below are used in practice to detect cancer in breast cells. Features are computed from a digitalized
image of a fine needle aspirate (FNA) of a breast mass. The real-valued features computed for each cell
nucleus are:
• Radius (mean of distances from center to points on the perimeter)
• Texture (standard deviation of gray-scale values)
• Perimeter
• Area
• Smoothness (local variation in radius lengths)
• Compactness (perimeter^2/area-1.0)
Concavity (severity of concave portions of the contour)
• Concave points (number of concave portions of the contour)
• Symmetry
• Fractal dimension
The mean, standard error, and largest value of these features were computed for each image resulting in
30 features. The training features can be found as cancer.train.csv, the corresponding labels can be found
as label.train.csv. Similarly, test data can be found as cancer.test.csv and label.test.csv. In the features
files, the first ten columns correspond to the mean values of the features, the next ten columns
correspond to the standard error and the last ten columns correspond to the largest value.
The response variable can take the values “B” (benign) or “M” (malign). We observe 𝑛𝑛 independent
observations (𝑦𝑦𝑖𝑖, 𝑥𝑥1𝑖𝑖, ... , 𝑥𝑥𝑝𝑝𝑖𝑖) for 𝑖𝑖 = 1, ... , 𝑛𝑛, where 𝑦𝑦𝑖𝑖 ∈ {𝐵𝐵, 𝑀𝑀}.
The models that you need to use to detect cancer are:
• Logistic Regression
• Linear Discriminant Analysis
• Quadratic Discriminant Analysis
• Naïve Bayes
