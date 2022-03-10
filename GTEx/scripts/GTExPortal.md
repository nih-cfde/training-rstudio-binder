    library(tidyverse)

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──

    ## ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
    ## ✓ tibble  3.1.6     ✓ dplyr   1.0.7
    ## ✓ tidyr   1.1.4     ✓ stringr 1.4.0
    ## ✓ readr   2.1.1     ✓ forcats 0.5.1

    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

    library(kableExtra)

    ## 
    ## Attaching package: 'kableExtra'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     group_rows

    df <- read_csv("../data/GTExPortal.csv")

    ## Rows: 25713 Columns: 8

    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (8): Tissue Sample ID, Tissue, Subject ID, Sex, Age Bracket, Hardy Scale...

    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    dim(df)

    ## [1] 25713     8

    head(df) %>%
      kbl() %>%
      kable_minimal()

<table class=" lightable-minimal" style="font-family: &quot;Trebuchet MS&quot;, verdana, sans-serif; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Tissue Sample ID
</th>
<th style="text-align:left;">
Tissue
</th>
<th style="text-align:left;">
Subject ID
</th>
<th style="text-align:left;">
Sex
</th>
<th style="text-align:left;">
Age Bracket
</th>
<th style="text-align:left;">
Hardy Scale
</th>
<th style="text-align:left;">
Pathology Categories
</th>
<th style="text-align:left;">
Pathology Notes
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
GTEX-1117F-0126
</td>
<td style="text-align:left;">
Skin - Sun Exposed (Lower leg)
</td>
<td style="text-align:left;">
GTEX-1117F
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
6 pieces, minimal fat, squamous epithelium is ~50-70 microns
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-1117F-0226
</td>
<td style="text-align:left;">
Adipose - Subcutaneous
</td>
<td style="text-align:left;">
GTEX-1117F
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
2 pieces, ~15% vessel stroma, rep delineated
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-1117F-0326
</td>
<td style="text-align:left;">
Nerve - Tibial
</td>
<td style="text-align:left;">
GTEX-1117F
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
clean\_specimens
</td>
<td style="text-align:left;">
2 pieces, clean specimens
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-1117F-0426
</td>
<td style="text-align:left;">
Muscle - Skeletal
</td>
<td style="text-align:left;">
GTEX-1117F
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
2 pieces, !5% fibrous connective tissue, delineated (rep)
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-1117F-0526
</td>
<td style="text-align:left;">
Artery - Tibial
</td>
<td style="text-align:left;">
GTEX-1117F
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
monckeberg, sclerotic
</td>
<td style="text-align:left;">
2 pieces, clean, Monckebeg medial sclerosis, rep delineated
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-1117F-0626
</td>
<td style="text-align:left;">
Artery - Coronary
</td>
<td style="text-align:left;">
GTEX-1117F
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
2 pieces, up to 4mm aderent fat/nerve/vessel, delineated
</td>
</tr>
</tbody>
</table>

    df %>%
      ggplot(aes(x = `Tissue`, 
                 fill = `Sex`)) +
      geom_bar()  

![](../images/GTExPortal-1.png)

    df %>%
      ggplot(aes(x = `Tissue`, 
                 fill = `Sex`)) +
      geom_bar()  +
      coord_flip()

![](../images/GTExPortal-2.png)

    df2 <- df %>% 
      group_by(`Subject ID`, `Hardy Scale`, `Age Bracket`, Sex) %>%
      summarize(TissueCount = length(Tissue)) %>%
      arrange(desc(TissueCount))  

    ## `summarise()` has grouped output by 'Subject ID', 'Hardy Scale', 'Age Bracket'. You can override using the `.groups` argument.

    head(df2, 10) %>%
      kbl() %>%
      kable_minimal()

<table class=" lightable-minimal" style="font-family: &quot;Trebuchet MS&quot;, verdana, sans-serif; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Subject ID
</th>
<th style="text-align:left;">
Hardy Scale
</th>
<th style="text-align:left;">
Age Bracket
</th>
<th style="text-align:left;">
Sex
</th>
<th style="text-align:right;">
TissueCount
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
GTEX-12WSG
</td>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
50-59
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
36
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-1ICG6
</td>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
70-79
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
36
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-11ZTT
</td>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
35
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-14A6H
</td>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
30-39
</td>
<td style="text-align:left;">
male
</td>
<td style="text-align:right;">
35
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-12WSN
</td>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
40-49
</td>
<td style="text-align:left;">
male
</td>
<td style="text-align:right;">
34
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-131XF
</td>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
male
</td>
<td style="text-align:right;">
34
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-15EOM
</td>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
20-29
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
34
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-1117F
</td>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
33
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-11EMC
</td>
<td style="text-align:left;">
Fast death - natural causes
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
33
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-11ZTS
</td>
<td style="text-align:left;">
Fast death - natural causes
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
33
</td>
</tr>
</tbody>
</table>

    dim(df2)

    ## [1] 980   5

    df2 %>%
      ggplot(aes(fill = `Hardy Scale`, 
                 x = `Age Bracket`)) +
      geom_bar() +
      facet_wrap(~Sex) +
      theme(axis.text.x =  element_text(angle = 45, hjust = 1))

![](../images/GTExPortal-3.png)

    df3 <- df2 %>%
      group_by(`Hardy Scale`, `Age Bracket`, Sex) %>%
      summarise(count = length(`Subject ID`)) 

    ## `summarise()` has grouped output by 'Hardy Scale', 'Age Bracket'. You can override using the `.groups` argument.

    tail(df3,20) %>%
      kbl() %>%
      kable_minimal()

<table class=" lightable-minimal" style="font-family: &quot;Trebuchet MS&quot;, verdana, sans-serif; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Hardy Scale
</th>
<th style="text-align:left;">
Age Bracket
</th>
<th style="text-align:left;">
Sex
</th>
<th style="text-align:right;">
count
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
40-49
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
3
</td>
</tr>
<tr>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
40-49
</td>
<td style="text-align:left;">
male
</td>
<td style="text-align:right;">
8
</td>
</tr>
<tr>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
50-59
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
9
</td>
</tr>
<tr>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
50-59
</td>
<td style="text-align:left;">
male
</td>
<td style="text-align:right;">
20
</td>
</tr>
<tr>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
29
</td>
</tr>
<tr>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
male
</td>
<td style="text-align:right;">
38
</td>
</tr>
<tr>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
70-79
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
3
</td>
</tr>
<tr>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
70-79
</td>
<td style="text-align:left;">
male
</td>
<td style="text-align:right;">
5
</td>
</tr>
<tr>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
20-29
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
26
</td>
</tr>
<tr>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
20-29
</td>
<td style="text-align:left;">
male
</td>
<td style="text-align:right;">
45
</td>
</tr>
<tr>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
30-39
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
21
</td>
</tr>
<tr>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
30-39
</td>
<td style="text-align:left;">
male
</td>
<td style="text-align:right;">
42
</td>
</tr>
<tr>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
40-49
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
50
</td>
</tr>
<tr>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
40-49
</td>
<td style="text-align:left;">
male
</td>
<td style="text-align:right;">
62
</td>
</tr>
<tr>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
50-59
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
56
</td>
</tr>
<tr>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
50-59
</td>
<td style="text-align:left;">
male
</td>
<td style="text-align:right;">
113
</td>
</tr>
<tr>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
41
</td>
</tr>
<tr>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
male
</td>
<td style="text-align:right;">
59
</td>
</tr>
<tr>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
70-79
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
4
</td>
</tr>
<tr>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
70-79
</td>
<td style="text-align:left;">
male
</td>
<td style="text-align:right;">
6
</td>
</tr>
</tbody>
</table>

    df4 <- df3 %>%
      pivot_wider(names_from = `Age Bracket`,
                  values_from = `count`)
    df4 %>%
      kbl() %>%
      kable_minimal()

<table class=" lightable-minimal" style="font-family: &quot;Trebuchet MS&quot;, verdana, sans-serif; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Hardy Scale
</th>
<th style="text-align:left;">
Sex
</th>
<th style="text-align:right;">
20-29
</th>
<th style="text-align:right;">
30-39
</th>
<th style="text-align:right;">
40-49
</th>
<th style="text-align:right;">
50-59
</th>
<th style="text-align:right;">
60-69
</th>
<th style="text-align:right;">
70-79
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Fast death - natural causes
</td>
<td style="text-align:left;">
male
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
16
</td>
<td style="text-align:right;">
75
</td>
<td style="text-align:right;">
87
</td>
<td style="text-align:right;">
8
</td>
</tr>
<tr>
<td style="text-align:left;">
Fast death - natural causes
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:right;">
18
</td>
<td style="text-align:right;">
24
</td>
<td style="text-align:right;">
2
</td>
</tr>
<tr>
<td style="text-align:left;">
Fast death - violent
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
Fast death - violent
</td>
<td style="text-align:left;">
male
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
2
</td>
</tr>
<tr>
<td style="text-align:left;">
Intermediate death
</td>
<td style="text-align:left;">
male
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
27
</td>
<td style="text-align:right;">
2
</td>
</tr>
<tr>
<td style="text-align:left;">
Intermediate death
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
9
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
9
</td>
<td style="text-align:right;">
29
</td>
<td style="text-align:right;">
3
</td>
</tr>
<tr>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
male
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:right;">
20
</td>
<td style="text-align:right;">
38
</td>
<td style="text-align:right;">
5
</td>
</tr>
<tr>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:right;">
26
</td>
<td style="text-align:right;">
21
</td>
<td style="text-align:right;">
50
</td>
<td style="text-align:right;">
56
</td>
<td style="text-align:right;">
41
</td>
<td style="text-align:right;">
4
</td>
</tr>
<tr>
<td style="text-align:left;">
Ventilator case
</td>
<td style="text-align:left;">
male
</td>
<td style="text-align:right;">
45
</td>
<td style="text-align:right;">
42
</td>
<td style="text-align:right;">
62
</td>
<td style="text-align:right;">
113
</td>
<td style="text-align:right;">
59
</td>
<td style="text-align:right;">
6
</td>
</tr>
</tbody>
</table>

    ggplot(df3, aes(x = `Hardy Scale`, y = count,
                    fill = `Age Bracket`,
                    label = count)) +
      geom_bar(stat = "identity") +
      facet_wrap(~`Sex`) +
      coord_flip() +
      theme(legend.position = "none")

![](../images/GTExPortal-4.png)

    df5 <- df2 %>%
      group_by( `Age Bracket`) %>%
      summarise(count = length(`Age Bracket`)) 

    df5 %>%
      kbl() %>%
      kable_minimal()

<table class=" lightable-minimal" style="font-family: &quot;Trebuchet MS&quot;, verdana, sans-serif; margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Age Bracket
</th>
<th style="text-align:right;">
count
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
20-29
</td>
<td style="text-align:right;">
84
</td>
</tr>
<tr>
<td style="text-align:left;">
30-39
</td>
<td style="text-align:right;">
78
</td>
</tr>
<tr>
<td style="text-align:left;">
40-49
</td>
<td style="text-align:right;">
153
</td>
</tr>
<tr>
<td style="text-align:left;">
50-59
</td>
<td style="text-align:right;">
314
</td>
</tr>
<tr>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:right;">
318
</td>
</tr>
<tr>
<td style="text-align:left;">
70-79
</td>
<td style="text-align:right;">
33
</td>
</tr>
</tbody>
</table>

    ggplot(df5, aes(x = `Age Bracket`, y = count,
                    fill = `Age Bracket`,
                    label = count)) +
      geom_bar(stat = "identity") +
      geom_text(aes(label = count)) +
      theme(legend.position = "none")

![](../images/GTExPortal-5.png)
