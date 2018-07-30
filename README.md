# MTI830 - ÉTSMINE 2018
## Prédictions des marchés de capitaux avec l'analyse de sentiments
### par Michael Faille et Benoit Paquet
 
# Préambule
## Déroulement de la présentation
* Introduction 
* Présentation de nos experts
* Premières expériences
* Méthodes
* Expérience
* Résultats
* Conclusion

## Introduction

![](https://raw.githubusercontent.com/MTI830PyTraders/mti830pytraders.github.io/master/xkcd_half.jpg)

## Objectif
#### Faire la prédiction de la valeur d'une action dans le futur avec:
* Le deep learning
* Le cours de la bourse
* L'analyse de sentiments
* Les informations financières des compagnies

# Présentation de nos experts
## Présentation de Francis
* Partenaire d'affaire de Michael
* Ancien étudiant du MILA et diplômé en maîtrise à la Polytechnique
* Expert en Machine Learning et en investissement à la bourse
* a proposé l'hypothèse suivante:
  * Stock price * Sentiments = Discounted Cash Flow

## Présentation de Carl
* Détient un MBA du HEC
* Fondateur de la startup Evovest
* Expert en finance et en machine learning

# Premières expériences
## Expérimentation avec sentiment140
#### Sentiment140 c'est:
* 1.6 millions de tweets disponible publiquement sur internet
* Publié par des étudiants en science informatique de l'université de Stanford
* Notre premier contact avec le deep learning
* Être capable d'attribuer un sentiment à une phrase grâce à un modèle

## Expérimentation avec sentiment140
#### Nos résultats nous ont démontrés qu'il:
* est difficile de corréler le sentiment avec la bourse
* nécessite beaucoup plus de travail pour valider le modèle
* nécessite encore plus de travail pour mettre la main sur un autre dataset de Twitter

# Recommendations de nos experts
## Dataset: FinSents
#### Caractéristiques:
* Génère une valeur de sentiment par jour par compagnie
* La valeur provient de différentes sources:
  * Les journaux
  * Différents réseaux sociaux (comme Twitter)
  * Les blogues
* Dizaine de milliers de compagnies
* Offre d'autres colonnes tels le News Buzz et le News Volume

## Dataset: FinSents
#### Couvre les sentiments de compagnies à travers le monde:
  * 15 000 nord-américaines
  * 8 000 européennes
  * 4 000 japonaises
  * 14 000 asiatiques à l'exclusion du Japon
  * 3 000 Australie / Nouvelle-Zélande
  * 1 000 sud-américaines

## Dataset: Sharadar
#### Source d'information financière:
* Sur plus de 12 000 compagnies américaines
* Représente plus d'une centaine d'attributs par compagnie
* Contient jusqu'à 20 ans d'historique
* Offre aussi l'information de la bourse pour ces compagnies

## Datasets
#### Possibilités de FinSents et Sharadar:
* Combinaison possible des datasets avec la date et le ticker
* disponibles sur Quandl
* Possibilité d'utiliser l'API de Quandl
* Possibilité de télécharger les datasets complets au format CSV
* Datasets payants au coût de 50$ par mois

#  Méthodes - Préparation des données
## Préparation - Finsents

* Filtrer les compagnies qui ne sont pas aux États-Unis
* Uniformiser la colone des tickers pour merge.
  * \<ticker\>_\<pays\> -> \<ticker\>
* Suppression des rangés ayant le volume nouvelles collectés à zéro.

## Préparation - Sharadar Core US Fundamentals
* «datekey» a été choisi comme index
* Choix de «MRQ» «Most-recent reported Quarter» comme type d'entré
* Filtrer les tickers:
  * maximum de données pour le laps de temps désiré.


## Préparation - Sharadar US Equities and Fund Prices
* Aucun travail particulier ne s'est fait sur ce dataset.

## Fusion des données
#### On garde seulement les tickers communs aux datasets
* Quandl - Finsents:
    * 3,4Go -> 44M 12%
* Quandl - Sharadar Core US Fundamentals :
    * 347Mo -> 37Mo 10,6%
* Quandl - Sharadar US Equities and Fund Prices :
    * 492Mo -> 215M 43,7%

## Résultat de la fusion des datasets :
* Données interpolés linéairement aux jours
* Taille : 4.5 go au total
* Format : netcdf pour plusieurs dimensions
* Bibliothèques : Streaming de données depuis le disque
    * Usage de Xarray et Pandas
* Multi-index (cube) : Data + Ticker

## Présentation du LSTM
![](https://upload.wikimedia.org/wikipedia/commons/6/63/Long_Short-Term_Memory.svg)
Source: wikipedia.org (Réseau de neurones récurrents)

## Présentation du LSTM
#### LSTM c'est:
* Long short-term memory
* Un type de réseau de neurones récurrent
* Incoutournable pour les séries temporelles

## Présentation du LSTM
#### Problème de série temporelle donc:
Adapté pour le comportement du chagement du prix des actions varie dans le temps

## Implémentation du LSTM
* Implémentation "stateful"
* Implémenté avec Tensorflow
* Utilise l'API de Keras
* Multidimensionnel

## Paramètres du LSTM
```toml
[fcf_MCD]
extra_input = ['fcf']
tickers = ['MCD']
BATCH_SIZE = 90
LOSS = 'mae'
N_HIDDEN = 1000
NUM_EPOCHS = 100
SAVE_EVERY = 10
NUM_TIMESTEPS = 180
LEARNING_RATE = 0.001
BEGINNING_DATE = '2013-03-31'
ENDING_DATE = '2018-06-31'
TIMESTEPS_AHEAD = 7
```

# Expérience

## Compagnies du test:
* AAPL - Apple
* MSFT - Microsoft
* MCD - McDonalds
* WCD - Western Digitals
* DIS - Disney
* INTC - Intel

## Features choisis ?

#### Les voici :
* Sentiments
* Price-to-Earnings Ratio
* Price-to-Book Ratio
* Debt-to-Equity
* Free Cash Flow
* PEG Ratio

Source: Investopedia 5 must-have metrics for value investors

## Échantillons retenus
#### 7 échantillons / 30 (les plus intéressants)
* Microsoft - PB
* Microsoft - DE
* Microsoft - PE
* Apple - FCF
* Apple - PB
* Disney - PE
* McDonalds - FCF

# Résultats

## Microsoft - PB - Loss
![](https://raw.githubusercontent.com/MTI830PyTraders/mti830pytraders.github.io/master/RESULTS/pb_MSFT/loss.png)

## Microsoft - PB
<center>
<video autoplay="true" loop="true" muted="true" width="640" controls>
   <source src="https://github.com/MTI830PyTraders/mti830pytraders.github.io/raw/master/video/pb_MSFT.webm" type="video/webm"> Your browser does not support the video tag. https://github.com/MTI830PyTraders/mti830pytraders.github.io/raw/master/video/pb_MSFT.webm
</video>
</center>

## Microsoft - DE - Loss
![](https://raw.githubusercontent.com/MTI830PyTraders/mti830pytraders.github.io/master/RESULTS/de_MSFT/loss.png)

## Microsoft - DE
<center>
<video autoplay="true" loop="true" muted="true" width="640" controls>
   <source src="https://github.com/MTI830PyTraders/mti830pytraders.github.io/raw/master/video/de_MSFT.webm" type="video/webm"> Your browser does not support the video tag. https://github.com/MTI830PyTraders/mti830pytraders.github.io/raw/master/video/de_MSFT.webm
</video>
</center>

## Microsoft - PE - Loss
![](https://raw.githubusercontent.com/MTI830PyTraders/mti830pytraders.github.io/master/RESULTS/pe_MSFT/loss.png)

## Microsoft - PE
<center>
<video autoplay="true" loop="true" muted="true" width="640" controls>
   <source src="https://github.com/MTI830PyTraders/mti830pytraders.github.io/raw/master/video/pe_MSFT.webm" type="video/webm"> Your browser does not support the video tag. https://github.com/MTI830PyTraders/mti830pytraders.github.io/raw/master/video/pe_MSFT.webm
</video>
</center>

## Apple - FCF - Loss
![](https://raw.githubusercontent.com/MTI830PyTraders/mti830pytraders.github.io/master/RESULTS/fcf_AAPL/loss.png)

## Apple - FCF
<center>
<video autoplay="true" loop="true" muted="true" width="640" controls>
   <source src="https://github.com/MTI830PyTraders/mti830pytraders.github.io/raw/master/video/fcf_AAPL.webm" type="video/webm"> Your browser does not support the video tag. https://github.com/MTI830PyTraders/mti830pytraders.github.io/raw/master/video/fcf_AAPL.webm
</video>
</center>

## Apple - PB - Loss
![](https://raw.githubusercontent.com/MTI830PyTraders/mti830pytraders.github.io/master/RESULTS/pb_AAPL/loss.png)

## Apple - PB
<center>
<video autoplay="true" loop="true" muted="true" width="640" controls>
   <source src="https://github.com/MTI830PyTraders/mti830pytraders.github.io/raw/master/video/pb_AAPL.webm" type="video/webm"> Your browser does not support the video tag. https://github.com/MTI830PyTraders/mti830pytraders.github.io/raw/master/video/pb_AAPL.webm
</video>
</center>

## Disney - PE - Loss
![](https://raw.githubusercontent.com/MTI830PyTraders/mti830pytraders.github.io/master/RESULTS/pe_DIS/loss.png)

## Disney - PE
<center>
<video autoplay="true" loop="true" muted="true" width="640" controls>
   <source src="https://github.com/MTI830PyTraders/mti830pytraders.github.io/raw/master/video/pe_DIS.webm" type="video/webm"> Your browser does not support the video tag. https://github.com/MTI830PyTraders/mti830pytraders.github.io/raw/master/video/pe_DIS.webm
</video>
</center>

## McDonalds - FCF - Loss
![](https://raw.githubusercontent.com/MTI830PyTraders/mti830pytraders.github.io/master/RESULTS/fcf_MCD/loss.png)

## McDonalds - FCF
<center>
<video autoplay="true" loop="true" muted="true" width="640" controls>
   <source src="https://github.com/MTI830PyTraders/mti830pytraders.github.io/raw/master/video/fcf_MCD.webm" type="video/webm"> Your browser does not support the video tag. https://github.com/MTI830PyTraders/mti830pytraders.github.io/raw/master/video/fcf_MCD.webm
</video>
</center>

## Résultat moyen par feature lors des 10 dernières époques
```
Feature: pe
MAPE     MAE        MAPE_val  MAE_val
64326.5  0.0105203  38.5159   0.0376469

Feature: de
MAPE     MAE         MAPE_val  MAE_val
15788.3  0.00253461  10.7115   0.0148578
```

##

```
Feature: pb
MAPE     MAE         MAPE_val  MAE_val
11785.5  0.00141338  7.87596   0.00641467

Feature: fcf
MAPE     MAE         MAPE_val  MAE_val
10748.8  0.00201642  5.94198   0.00462182

Feature: peg
MAPE   MAE         MAPE_val  MAE_val
14452  0.00176067  6.50103   0.00528985
```

# Conclusion
##
![](https://raw.githubusercontent.com/MTI830PyTraders/mti830pytraders.github.io/master/xkcd.jpg)

## Travaux futurs
* Évaluer la pertinence des autres attributs du dataset
* Tester avec plus de tickers
* Utiliser plusieurs tickers pour entrainer un même modèle
* Modifier les paramètres d'entrainement du modèle
* Entrainer d'autres types de modèles et comparer les résultats
* Discounted Cash Flow (DCF)
    *  Interpoler le DCF avec le Random Forest
    *  Prédire le DCF
    *  Prédire quand échanger avec le DCF du futur

## Remerciements
#### Merci à:
* Sylvie Ratté pour son suivi sur le projet
* Francis Piéraut pour nous avoir introduit ce projet
* Michael Faille pour avoir sollicité Francis Piéraut dans la définition du projet.
* Carl Dussault pour ses conseils sur la finance

## Merci pour votre attention!
## Questions?

code source disponible à <br>
github.com/MTI830PyTraders/TradingPlayground
