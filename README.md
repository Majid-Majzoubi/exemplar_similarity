# The Double-Edged Sword of Exemplar Similarity

This repository contains the code for the paper "The Double-Edged Sword of Exemplar Similarity". In addition to the source codes provided in this repository, we are sharing the embeddings on Harvard Dataverse, which can be accessed at this link: [https://doi.org/10.7910/DVN/Y79OCK](https://doi.org/10.7910/DVN/Y79OCK). You can simply visit the link and download the embeddings directly.

If you use these codes or the data in your research, please ensure that you appropriately cite our paper:

Majzoubi, Zhao, Zuzul, Fisher, 2024. "The Double-Edged Sword of Exemplar Similarity". Organization Science.

## Abstract
We investigate how a firm’s positioning relative to category exemplars shapes security analysts’ evaluations. Employing a two-stage model of evaluation (initial screening and subsequent assessment), we posit that exemplar similarity enhances a firm’s recognizability and legitimacy, thereby increasing the likelihood of it passing the initial screening stage and attracting analyst coverage. However, exemplar similarity may also prompt unfavorable comparisons with exemplar firms, leading to lower analyst recommendations in the assessment stage. We further argue that category coherence, distinctiveness, and exemplar typicality influence the impact of exemplar similarity on firm evaluation. Leveraging Natural Language Processing (NLP) techniques to analyze a sample of 7,603 US public firms from 1997 to 2022, we find robust support for our predictions. By highlighting the nuanced implications of strategic positioning vis-à-vis category exemplars in shaping audience evaluations, our findings contribute to management research on optimal distinctiveness, categories, and security analysts.


## Repository Structure
The repository is structured as follows:
- `source/`: Contains all the main source code files.
- `source/supplementary_analysis/`: This folder contains source codes for analyses that are included as robustness checks and supplementary analysis in the paper.
- `data/`: Placeholder for the data used in the study. Due to copyright concerns, the actual data is not provided in the repository. All the data needed for this analysis could be downloaded using WRDS and SEC-API subscriptions.

## Usage
To reproduce the results in the paper, run the notebooks in the following order:
1. [`download_parse_10ks.ipynb`](https://github.com/Majid-Majzoubi/exemplar_similarity/blob/main/source/download_parse_10ks.ipynb): This notebook downloads the "Item 1" section of 10-K filings.
2. [`10k_mpnet_embeddings.ipynb`](https://github.com/Majid-Majzoubi/exemplar_similarity/blob/main/source/10k_mpnet_embeddings.ipynb): This notebook generates embeddings for the 10-K filings using a pre-trained model. (*** Note: this part of the code requires a powerful GPU. It took us about a week to process using an H100 GPU on Google Cloud services. With a regular CPU it can take months to process).
3. [`10k_embeddings_todf.ipynb`](https://github.com/Majid-Majzoubi/exemplar_similarity/blob/main/source/10k_embeddings_todf.ipynb): This notebook transforms the embeddings into a dataframe.
4. [`10k_vars_notebook.ipynb`](https://github.com/Majid-Majzoubi/exemplar_similarity/blob/main/source/10k_vars_notebook.ipynb): This notebook constructs variables such as exemplar similarity, category coherence, and distinctiveness.
5. [`accounting_vars_notebook.ipynb`](https://github.com/Majid-Majzoubi/exemplar_similarity/blob/main/source/accounting_vars_notebook.ipynb): This notebook uses Compustat data to create control variables and combines all the variables together.
6. [`main_regression_models_notebook.ipynb`](https://github.com/Majid-Majzoubi/exemplar_similarity/blob/main/source/main_regression_models_notebook.ipynb): This notebook runs the regression models based on the constructed variables.



## License
[MIT License](LICENSE)
