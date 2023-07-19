# Unraveling the Complexity of Exemplar Similarity in Firm Evaluation: A Two-Stage Approach

This repository contains the code for the paper "Unraveling the Complexity of Exemplar Similarity in Firm Evaluation: A Two-Stage Approach". 

## Abstract
We investigate the role of category exemplars in shaping security analysts' evaluations of firms. We base our arguments on the sequential nature of the evaluation process, which involves two stages: screening and selection. We examine how a firm's similarity to an exemplar impacts these stages. We propose that exemplar similarity enhances a firm's recognizability and legitimacy, thus increasing the likelihood of passing the initial screening stage and earning analyst coverage. However, it may also lead to unfavorable comparisons in the second stage, resulting in lower analyst recommendations. We further explore the influence of category viability and the position of an exemplar within it. We argue that category coherence, category distinctiveness, and an exemplar’s typicality within the category influence the impact of exemplar similarity on firm evaluation. Utilizing state-of-the-art Natural Language Processing (NLP) techniques on a sample of 7,603 US public firms spanning 1997 to 2022, we find robust support for our predictions. Our findings contribute to management research on categories and security analysts, underscoring the complexities of strategic positioning against category exemplars in shaping audience evaluations.

## Repository Structure
The repository is structured as follows:
- `source/`: Contains all the source code files.
- `data/`: Placeholder for the data used in the study. Due to copyright concerns, the actual data is not provided in the repository. All the data needed for this analysis could be downloaded using WRDS and SEC-API subscriptions.

## Usage
To reproduce the results in the paper, run the scripts in the following order:
1. `download_parse_10ks.ipynb`: This script downloads the "Item 1" section of 10-K filings.
2. `10k_mpnet_embeddings.ipynb`: This script generates embeddings for the 10-K filings using a pre-trained model. (*** Note: this part of the code requires a powerful GPU. It took us about a week to process using an H100 GPU on Google Cloud services. With a regular CPU it can take months to process).
3. `10k_embeddings_todf.ipynb`: This script transforms the embeddings into a dataframe.
4. `10k_vars_notebook.ipynb`: This script constructs variables such as exemplar similarity, category coherence, and distinctiveness.
5. `accounting_vars_notebook.ipynb`: This script uses Compustat data to create control variables and combines all the variables together.
6. `main_regression_models_notebook.ipynb`: This script runs the regression models based on the constructed variables.

## License
[MIT License](LICENSE)
