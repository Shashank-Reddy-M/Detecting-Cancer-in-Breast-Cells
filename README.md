# Detecting Cancer in Breast Cells
In this project, I will build a set of different models to diagnose breast cancer. Images as the one
shown below are used in practice to detect cancer in breast cells.

<p align="center">
  <img width="350" alt="Screenshot 2022-10-31 at 12 08 34 PM" src="https://user-images.githubusercontent.com/114110108/199058014-d5554aee-f53d-4911-bec1-f5cbac654b70.png">
</p>

The real-valued features computed for each cell nucleus are:
- Radius (mean of distances from center to points on the perimeter)
- Texture (standard deviation of gray-scale values)
- Perimeter
- Area
- Smoothness (local variation in radius lengths)
- Compactness (perimeter^2/area-1.0)
- Concavity (severity of concave portions of the contour)
- Concave points (number of concave portions of the contour)
- Symmetry
- Fractal dimension

In the features files, the first ten columns correspond to the mean values of the features, the next ten columns
correspond to the standard error and the last ten columns correspond to the largest value.
The models that I used to detect cancer are:
- Logistic Regression (LR)
- Linear Discriminant Analysis (LDA)
- Quadratic Discriminant Analysis (QDA)
- Naïve Bayes (NB)
## Results
#### LDA plot
    
<p align="center">
  <img width="360" height="200" src="https://user-images.githubusercontent.com/114110108/199062367-11f2e602-a204-413a-92b2-cf0200f07fd0.png">
</p>
    
#### NB plot
<p align="center">
  <img width="360" height="200" src="https://user-images.githubusercontent.com/114110108/199062541-15db23fd-cc19-44d9-b096-7b72e864fce8.png">
</p> 
    
The table for the testing and training errors for all the models are as follows,
<p align="center">
  <img width="300" height="200" src="https://user-images.githubusercontent.com/114110108/199062699-666701fc-5413-4859-8a35-692b1a7026d2.png">
</p> 
  

Training error are all smaller than test errors. A poor performance of Naive Bayes suggests that variables are
not independent. Linear discriminant analysis works the best while Logistic regression also has relatively
small training and test errors. Since the LDA and logistic regression performs better, the true decision
boundaries is close to linear.
