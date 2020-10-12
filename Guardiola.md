---
title: "Pep Guardiola's Tatical Mastermind"
author: "Will Orser & Floyd Krom"
output: 
  html_document:
    keep_md: TRUE
    toc: TRUE
    toc_float: TRUE
    theme: journal
    df_print: paged
    code_download: true
---









# I. Introduction

  Pep Guardiola is considered to be one of the greatest tactical masterminds in modern football. He is a coach who possesses all the skills and experience to transform any team into a dominant champion in any worldwide competition. As a manager, Guardiola holds the record for the most consecutive league games won in La Liga (Spain), the Bundesliga (Germany), and the English Premier League. Guardiola has managed to win a total of 30 trophies in his career as manager of Barcelona, Bayern Munich, and his current club, Manchester City. How did Guardiola change the style of play and influence the performance of English football club Manchester City after his appointment as manager in July 2016?  

  The purpose of this study is to perform a comparative analysis of the style of play and performance of the football club Manchester City before and after the appointment of Pep Guardiola. We will evaluate data from the 2013-14 season through the 2018-19 season. During the first three seasons covered in our analysis (2013-14, 2014-15, 2015-16), Manuel Pellegrini was manager of Manchester City, leading them to one Premier League title in the 2013-14 season. Following the removal of Pelligrini in June 2016, Pep Guardiola was appointed manager and was expected to completely change Manchester City's style of play with his world famous Tika-Taka style.

  In order to answer our primary research question, we will explore the following secondary research questions:

· How did Manchester City perform offensively over the seasons?

· How did Manchester City perform defensively over the seasons?

· How did Manchester City perform against teams in the bottom-half of the league table compared to teams in the top-half of the table over the seasons? 

· How did Manchester City perform during Pellegrini's tenure as manager compared to during Guardiola's tenure?

  As football players and fans, it is hard not to admire the characteristic style of play of Guardiola's teams and the way he is consistently able to build his teams into the dominant force in their respective leagues. In the documentary "All or Nothing: Manchester City", it is crystal clear that Guardiola has a remarkable obsession with the tactical side of soccer and the style of play of his side. Everything Guardiola does as a manager seems to stem from an almost pathological attention to detail. As any football player will tell you, small details, performed consistently over time, can make the difference needed to crown a team champion at the end of the season. We are motivated to achieve a better understanding of these details through this analysis. 

  This study is divided into six sections. The following section includes a biography of Pep Guardiola, including his time as a professional football player and as a coach. Next, we will then present the style of play Guardiola has implemented at Manchester City and how it has changed over the seasons. We will then introduce our data before analyzing the results of various statistical transformations and visualizations. In the fifth section, we will summarize our findings and provide limitations and future research possibilities as an extension to this study. 


**II. Pep Guardiola**

  Guardiola spent the majority of his playing career as a defensive midfielder for Spanish club Barcelona. Johan Cruyff, one of football's most legendary players, as manager of Barcelona, transformed the club into a celebrated champion, with Guardiola playing a central role, as they won the club's first ever European Cup in 1992 and four La Liga titles from 1991 to 1994. Guardiola also captained Barcelona from 1997 until his departure from the club in 2001. He earned 47 caps (appearances) for the Spanish national team, and was part of the team at the 1994 World Cup and Euro 2000. After his retirement as a player, Guardiola became the coach of Barcelona B. After being appointed as manager of Barcelona's first team in May 2008, Guardiola immediately made his mark by telling key players like Ronaldinho, Deco, and Samuel Eto'o that they were not part of his plans. Guardiola then went on to sign defenders Dani Alves and Gerard Piqué, and promoted youth players Sergio Busquets and Pedro to the first team. All three of these players would go on to be key figures in Barcelona's era of dominance in modern football. In his first season at Barcelona, Guardiola guided his side to the treble: winning La Liga, La Copa del Rey, and the UEFA Champions League. This feat made him the youngest ever manager to accomplish this. When Guardiola left the club in 2012, he had won 14 trophies as manager of Barcelona, a historical club record. 

*[Source: https://www.kicker.de/fc-bayern-muenchen/team-trainer/bundesliga/2013-14]*

*[Source: https://www.nytimes.com/2018/04/06/sports/soccer/manchester-city-united-pep-guardiola.html]*

After a short sabbatical and an intensive German language course, Guardiola was announced as the new manager of Bayern Munich in 2013. During his time at one of the greatest clubs in the history of football, Guardiola won the Bundesliga in three consecutive seasons, including two domestic doubles. 

While Guardiola's Bayern side won a domestic double in his final year in 2016, Manchester City only managed to take fourth place in the English Premier League. The fourth place finish qualified City for a spot in next season's Champions League, an annual club football competition contested by the top clubs in Europe. In February of 2016, Manchester City announced the appointment of Pep Guardiola as manager for their upcoming season. Many blame the subpar performance of Manchester City during the 2015-16 season and the failure of Manuel Pelligrini during his final season in charge on this mid-season announcement of Guardiola's impending arrival. Before Pep's appointment was announced, Manchester City were only three points short of first place in the Premier League. By the end of the season, they had fell 15 points behind champion Leicester City and only barely qualified for the group stage of next season's Champions League. During Pellegrini's tenure at Manchester City from 2013 to 2016, he managed to win one Premier League title and two League Cups. 

*[Source: https://www.manchestereveningnews.co.uk/sport/football/football-news/man-city-pellegrini-guardiola-destabilising-11336011]*

During Guardiola's first year as a Manchester City manager, he signed critical players, such as Oleksandr Zinchenko, Leroy Sané, İlkay Gündoğan, Claudio Bravo, and Gabriel Jesus. Guardiola is known for transforming the playing style of any new team he manages. Doing so requires making signings that fit into his desired style of play and plan for the team. During a disappointing 2016-17 season at Manchester City, Guardiola did not manage to win any trophies. However, his first season in charge allowed him to identify the changes necessary to improve the team in the battle for the Premier League title in the upcoming 2017-18 season. He made new acquisitions in the summer transfer window, signing goalkeeper Ederson Moraes, midfielder Bernardo Silva, as well as full-backs Danilo, Benjamin Mendy, and Kyle Walker, while dropping all four senior full backs from his team. The Manchester City squad had the fourth highest average squad age in the entire Premier League during the 2016-17 season, which explains some of Guardiola's challenges during his first season in charge. The signings made in the lead up to the 2017-18 season made Manchester City the 6th youngest squad in the league. 

In the weeks leading up to the final part of the 2017-18 season, Guardiola had managed to put Manchester City in a position to break several Premier League records. On 15 April 2018, Manchester City won the Premier League with the most wins (32) in league history, most away wins (16) in league history, most points (100) in league history, and the most goals (106) in league history. 2017-18 was a historical Premier League season for Manchester City and Guardiola's first title in England. Manchester City also managed to win the EFL Cup with a 3-0 victory over Arsenal. However, City were knocked out of the Champions League after losing both legs of their quarterfinal against Liverpool. 

During Guardiola's third season in charge, he signed attacking midfielder Riyad Mahrez from Leicester City for a fee of £60 million. Manchester City had fully adapted Guardiola's style of play and dominated the Premier League in the previous season. They immediately started their 2018-19 season with a trophy, the 2018 FA Community Shield, with a victory over Chelsea. In the 2018-19 season, Guardiola faced one of his biggest challenges as the manager of Manchester City. In order to win the title, Manchester City had to win 14 games in a row. Guardiola called it one of the toughest challenges in all his career. However, after all 38 games were played, Manchester City was once again on top of the league with 98 points, one point above Liverpool. City finished the 2018-19 season with 32 wins and an impressive 95 goals scored. Besides the FA Community Shield and Premier League title, Manchester City also managed to win the FA Cup and became one of the first ever men's teams in England to win the domestic treble. 


**III. Guardiola's Style of Play**

*General*

The style of play characteristic of teams coached by Pep Guardiola can be summarized by five pillars:

1. A high percentage of possession.

2. A high number of passes completed and a high percentage of passes completed.

3. Pushing the full-backs high into the attack to provide crosses.

4. An ability to keep possession under high pressure and to play the ball out from the back. 

5. Pressing and winning the ball back quickly once they lose possession. 

*Guardiola's Style of Play over The Years*

Below, we will identify key elements of Manchester City's team and how their style of play changed over the different seasons with Guardiola as manager.
  
*2016-2017 Season*

· Pep struggled to find his best XI during the 2016-17 season and experimented with eight different formations in 38 Premier League matches. 

· Most often, Manchester City played in a 4-3-3 formation. In this formation, Kevin de Bruyne and David Silva were assigned the "free 8" roles in the midfield, advancing to the "10" (attacking midfield) positions in possession and drawing back to the "6" (defensive midfield) positions in defense.  

· When Manchester City had possession in their own half, the defensive midfielder, Fernandinho, dropped in between the two center-backs, who spread wide. Kolarov, as a left-footed left center-back was able to distribute the ball to both wingers as he averaged the most long passes per match for Manchester City during the 2016-17 season (4.2 long passes per game on average).

· At Barcelona and Bayern Munich, Pep Guardiola had full-backs who were capable of dominating the entire left and right flank. However, during the 2016-17 season with Manchester City, Guardiola's full-backs were older players who proved to be incapable of fitting into his desired style of play. 

· Guardiola played with a 3-2-5 formation in attack with the two center-backs and the "6" in the back, both full-backs in front of them to secure the midfield, pushing up the "8s" (box-to-box midfield), Kevin de Bruyne and David Silva, into advanced "10" positions in support of the attacking front 3 players. This was done in possession in the opponent's half of the field with the aim of congesting the center of the field in order to prevent counterattacks. 

· One of the main challenges in this season was build-up play. Both full-backs who controlled the midfield in possession were not good enough on the ball, which slowed down the ball progression and therefore hindered City's attack. 

· Despite facing these challenges, there was an overall improvement in the 2016-17 season as Manchester City scored more goals, had a higher average possession percentage, and a higher passing average per game than during the 2015-16 season under Pellegrini. 

· Ultimately, Manchester City lost in the fourth round of the Carabao Cup, the semi-finalls of the FA Cup, and the Round of 16 of the Champions League. On top of all of this, they were only able to secure third place in the Premier League, finishing 15 points behind Premier League champion Chelsea. 

*2017-2018 Season*

· With the signings of full-backs Danilo, Benjamin Mendy, and Kyle Walker, Pep Guardiola changed to a 5-3-2 formation. He was able to change from a 4-3-3 formation to a 5-3-2 formation because his full-backs were able to dominate the entire flank and therefore fit better into Guardiola's desired style of play.

· Due to an early season injury of Mendy (the left full-back), Pep Guardiola changed back to the 4-3-3 formation while transforming central midfielder Fabian Delph into a left full-back. 

· New goalkeeper Ederson Moraes became vital in Guardiola's style of play as he was able to comfortably become part of Manchester City's possession game, building out from the back as well as playing long range passes with extreme precision. This allowed Manchester City to easily break pressure from the opponent in their own half with Ederson playing accurate long range passes over the opponent's lines, allowing the City forwards to make penetrating runs behind. 

· In Manchester City's build-up play, the full-backs played a key role. Left-back Delph would tuck into the midfield, creating a three-player back line with Walker to the right of the center-backs. This allowed Fernandinho to get possession in the midfield instead of dropping in between the two center-backs like he had done during the 2016-17 season. During the 2017-18 season, Fernandinho increased in his average number of passes per game from 68 to 88, and thus was able to dictate City's build-up play. 

· The Delph and Fernandinho combination in midfield increased the speed of City's build-up play compared to the duo of Bacary Sagna & Gael Clichy in the previous season. At the same time, right-back Kyle Walker had a better understanding of his role as a full-back and was able to determine when to stay behind as a center-back and when to push higher up to join the attack and serve crosses. 

· Both Kevin de Bruyne and David Silva kept similar roles to the 2016-17 season, but now had the ability to come into positions to influence the opponent's midfielders and entire defense line with their play. They were able to choose between making penetrating passes to their wingers behind the opponent's back line, combination passes with the striker, crossing from the outside the box, and taking direct shots on goal. 

· The key changes to Manchester City's style of play and the new signings that fit into this style of play brought Manchester City a historic season:

  - 32 wins (most in Premier League history)
  
  - 16 away wins (most in Premier League history)
  
  - 100 points (most in Premier League history)
  
  - 106 goals (most in Premier League history)
  
  - 19 point title winning margin (biggest in Premier League history)
  
· Manchester City and Pep Guardiola also managed to win the EFL cup during this season, but were knocked out of the Champions League quarterfinal by Premier League opponent, Liverpool.

*2018-2019 Season*

· For this season, Guardiola only signed attacking midfielder Mahrez and kept a very similar first team squad compared to the previous season.

· Guardiola made minor tweaks to his style of play rather than major changes as his team had become more accustomed to his football philosophy. One of the tweaks he made was to increase the involvement of full-backs Kyle Walker and Oleksandr Zinchenko. Zinchenko's speed allowed him to dominate the left flank more consistently than Delph had in the previous season. This allowed wingers Raheem Sterling and Leroy Sané to play more centrally (closer to the box), with Walker and Zichenko providing crosses from wide positions. 

· Injury challenges during this season forced Guardiola to pivot his starting XI and change their style of play. He would often play Fernandinho as a center-back instead of as a defensive midlfielder and start Aymeric LaPorte as a left-back instead of his usual position of center-back. In possession, Fernandinho would be able to overload the midfield, dictating the build-up play with the support of David Silva, City's central midfielder.

· Manchester City continued to dominate competitions in England, winning the Premier League, Carabao Cup, and the FA Cup, to become one of the first ever men's teams in England to win the domestic treble.

*[Source: https://www.youtube.com/watch?v=1gHq-yspmso]*


**IV. Data**

In order to examine how the style of play and performance of football club Manchester City changed after the appointment of their current manager, Pep Guardiola, data from the 2013-14 season through the 2018-19 season has been drawn from Football Data – a football portal providing historical data on any competition worldwide, that includes information on every Premier League game. Football Data provides all data sets in Excel and CSV format for quantitative analysis. The variables in this Premier League data set include:

· Date = Match Date (dd/mm/yy)

· Time = Time of match kick off

· HomeTeam = Home Team

· AwayTeam = Away Team

· FTHG and HG = Full Time Home Team Goals

· FTAG and AG = Full Time Away Team Goals

· FTR and Res = Full Time Result (H=Home Win, D=Draw, A=Away Win)

· HTHG = Half Time Home Team Goals

· HTAG = Half Time Away Team Goals

· HTR = Half Time Result (H=Home Win, D=Draw, A=Away Win)

· Attendance = Crowd Attendance

· Referee = Match Referee

· HS = Home Team Shots

· AS = Away Team Shots

· HST = Home Team Shots on Target

· AST = Away Team Shots on Target

· HHW = Home Team Hit Woodwork

· AHW = Away Team Hit Woodwork

· HC = Home Team Corners

· AC = Away Team Corners

· HF = Home Team Fouls Committed

· AF = Away Team Fouls Committed

· HFKC = Home Team Free Kicks Conceded

· AFKC = Away Team Free Kicks Conceded

· HO = Home Team Offsides

· AO = Away Team Offsides

· HY = Home Team Yellow Cards

· AY = Away Team Yellow Cards

· HR = Home Team Red Cards

· AR = Away Team Red Cards

· HBP = Home Team Bookings Points (10 = yellow, 25 = red)

· ABP = Away Team Bookings Points (10 = yellow, 25 = red)

In order to perform the ideal analysis of Guardiola's impact at Manchester City, we would have liked to perform an analysis of the following variables in addition to those in our Football Data data set: passes (total), passes per game, pass accuracy %, crosses, cross accuracy %, saves, tackles, tackle success %, blocked shots, interceptions, clearances, duels won, and errors leading to goal. This would have allowed us to perform a more thorough analysis of Guardiola's change to City's style of play as well as the team's performance during his time as manager. 

**V. Results**


To do list for primary results:

Show City’s table position in the seasons before Guardiola and the seasons after Guardiola took over
Important stats (plot by season)
Number of Wins, Losses, Draws [total, home, away] - All Seasons Combined + For Each Season 2013-2019
Total points [total, home, away] - All Seasons Combined + For Each Season 2013-2019
Total shots [total, home, away] - All Seasons Combined + For Each Season 2013-2019
Total shots on target [total, home, away] - All Seasons Combined + For Each Season 2013-2019
Goals for [total, home, away] - All Seasons Combined + For Each Season 2013-2019
Goals against [total, home, away] - All Seasons Combined + For Each Season 2013-2019
Goals for at half-time [total, home, away] - All Seasons Combined + For Each Season 2013-2019
Goals against at half-time [total, home, away] - All Seasons Combined + For Each Season 2013-2019
Goal difference [total, home, away] - All Seasons Combined + For Each Season 2013-2019
Red cards [total, home, away] - All Seasons Combined + For Each Season 2013-2019
Yellow cards [total, home, away] - All Seasons Combined + For Each Season 2013-2019

To do list for secondary results:
Comparison shots vs. shots on target (total, home, away)
Comparison total points against bottom-half of the table vs. top-half of the table
Compare results against top 6 in different seasons
Compare PL title years vs. non-PL title years


```r
all_seasons <- bind_rows(list(`season1314` = season_1314, `season1415` = season_1415, `season1516`= season_1516, `season1617` = season_1617, `season1718` = season_1718, `season1819`= season_1819), .id = "season")
```


```r
all_seasons %>%
  filter(HomeTeam == "Man City" | AwayTeam == "Man City") %>%
  mutate(Game = case_when(HomeTeam == "Man City" ~ "Home",
                              HomeTeam != "Man City" ~ "Away")) %>%
  group_by(season, Game) %>%
  summarize(across(where(is.numeric),~sum(.x)))
```

```
## `summarise()` regrouping output by 'season' (override with `.groups` argument)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["season"],"name":[1],"type":["chr"],"align":["left"]},{"label":["Game"],"name":[2],"type":["chr"],"align":["left"]},{"label":["FTHG"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["FTAG"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["HTHG"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["HTAG"],"name":[6],"type":["dbl"],"align":["right"]},{"label":["HS"],"name":[7],"type":["dbl"],"align":["right"]},{"label":["AS"],"name":[8],"type":["dbl"],"align":["right"]},{"label":["HST"],"name":[9],"type":["dbl"],"align":["right"]},{"label":["AST"],"name":[10],"type":["dbl"],"align":["right"]},{"label":["HF"],"name":[11],"type":["dbl"],"align":["right"]},{"label":["AF"],"name":[12],"type":["dbl"],"align":["right"]},{"label":["HC"],"name":[13],"type":["dbl"],"align":["right"]},{"label":["AC"],"name":[14],"type":["dbl"],"align":["right"]},{"label":["HY"],"name":[15],"type":["dbl"],"align":["right"]},{"label":["AY"],"name":[16],"type":["dbl"],"align":["right"]},{"label":["HR"],"name":[17],"type":["dbl"],"align":["right"]},{"label":["AR"],"name":[18],"type":["dbl"],"align":["right"]}],"data":[{"1":"season1314","2":"Away","3":"24","4":"39","5":"7","6":"17","7":"191","8":"296","9":"66","10":"102","11":"162","12":"205","13":"76","14":"128","15":"25","16":"39","17":"2","18":"1"},{"1":"season1314","2":"Home","3":"63","4":"13","5":"29","6":"7","7":"377","8":"166","9":"136","10":"56","11":"189","12":"189","13":"155","14":"81","15":"33","16":"35","17":"0","18":"2"},{"1":"season1415","2":"Away","3":"24","4":"39","5":"12","6":"18","7":"220","8":"307","9":"77","10":"99","11":"168","12":"211","13":"82","14":"103","15":"22","16":"42","17":"0","18":"1"},{"1":"season1415","2":"Home","3":"44","4":"14","5":"19","6":"4","7":"361","8":"168","9":"129","10":"52","11":"234","12":"144","13":"170","14":"73","15":"35","16":"34","17":"1","18":"3"},{"1":"season1516","2":"Away","3":"20","4":"24","5":"12","6":"12","7":"172","8":"265","9":"59","10":"95","11":"198","12":"212","13":"93","14":"102","15":"30","16":"36","17":"1","18":"0"},{"1":"season1516","2":"Home","3":"47","4":"21","5":"20","6":"11","7":"347","8":"164","9":"115","10":"66","11":"197","12":"204","13":"155","14":"72","15":"25","16":"28","17":"0","18":"1"},{"1":"season1617","2":"Away","3":"22","4":"43","5":"14","6":"21","7":"175","8":"297","9":"62","10":"102","11":"224","12":"207","13":"66","14":"129","15":"43","16":"39","17":"0","18":"0"},{"1":"season1617","2":"Home","3":"37","4":"17","5":"15","6":"3","7":"336","8":"124","9":"115","10":"44","11":"188","12":"211","13":"151","14":"64","15":"32","16":"47","17":"4","18":"1"},{"1":"season1718","2":"Away","3":"13","4":"45","5":"7","6":"24","7":"132","8":"317","9":"47","10":"110","11":"186","12":"175","13":"56","14":"146","15":"36","16":"32","17":"1","18":"1"},{"1":"season1718","2":"Home","3":"61","4":"14","5":"21","6":"5","7":"347","8":"106","9":"151","10":"40","11":"169","12":"180","13":"138","14":"47","15":"26","16":"40","17":"1","18":"2"},{"1":"season1819","2":"Away","3":"11","4":"38","5":"4","6":"21","7":"123","8":"297","9":"43","10":"112","11":"165","12":"166","13":"43","14":"144","15":"24","16":"27","17":"1","18":"1"},{"1":"season1819","2":"Home","3":"57","4":"12","5":"28","6":"7","7":"386","8":"113","9":"148","10":"40","11":"162","12":"155","13":"143","14":"39","15":"17","16":"30","17":"0","18":"1"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>



```r
all_seasons %>%
  filter(HomeTeam == "Man City" | AwayTeam == "Man City") %>%
  mutate(Game = case_when(HomeTeam == "Man City" ~ "Home",
                              HomeTeam != "Man City" ~ "Away")) %>%
  group_by(season, Game) %>%
  summarize(across(where(is.numeric),~sum(.x))) %>%
  mutate(Shots = ifelse(Game == "Home", HS, AS)) %>%
  select(season, Game, Shots) %>%
  pivot_wider(names_from = Game,
              values_from = Shots, names_prefix = "Shots") %>%
  mutate(TotalShots = ShotsAway + ShotsHome)
```

```
## `summarise()` regrouping output by 'season' (override with `.groups` argument)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["season"],"name":[1],"type":["chr"],"align":["left"]},{"label":["ShotsAway"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["ShotsHome"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["TotalShots"],"name":[4],"type":["dbl"],"align":["right"]}],"data":[{"1":"season1314","2":"296","3":"377","4":"673"},{"1":"season1415","2":"307","3":"361","4":"668"},{"1":"season1516","2":"265","3":"347","4":"612"},{"1":"season1617","2":"297","3":"336","4":"633"},{"1":"season1718","2":"317","3":"347","4":"664"},{"1":"season1819","2":"297","3":"386","4":"683"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

**Total points [total, home, away] - all seasons**

```r
all_seasons %>%
  filter(HomeTeam == "Man City" | AwayTeam == "Man City") %>%
  mutate(HomePoints = case_when(FTR == "H" ~ 3,
                                FTR == "A" ~ 0,
                                FTR == "D" ~ 1),
         AwayPoints = case_when(FTR == "H" ~ 0,
                                FTR == "A" ~ 3,
                                FTR == "D" ~ 1),
         HomeGame = case_when(HomeTeam == "Man City" ~ TRUE,
                              HomeTeam != "Man City" ~ FALSE),
         TotalHomePoints = case_when(HomeGame == TRUE ~ HomePoints),
         TotalAwayPoints = case_when(HomeGame == FALSE ~ AwayPoints)) %>%
  group_by(season) %>%
  summarize(TotalHomePoints = sum(TotalHomePoints, na.rm = TRUE),
            TotalAwayPoints = sum(TotalAwayPoints, na.rm = TRUE),
            TotalPoints = TotalHomePoints + TotalAwayPoints)
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["season"],"name":[1],"type":["chr"],"align":["left"]},{"label":["TotalHomePoints"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["TotalAwayPoints"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["TotalPoints"],"name":[4],"type":["dbl"],"align":["right"]}],"data":[{"1":"season1314","2":"52","3":"34","4":"86"},{"1":"season1415","2":"45","3":"34","4":"79"},{"1":"season1516","2":"38","3":"28","4":"66"},{"1":"season1617","2":"40","3":"38","4":"78"},{"1":"season1718","2":"50","3":"50","4":"100"},{"1":"season1819","2":"54","3":"44","4":"98"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

**Number of Wins, Losses, Draws [Total, Home, Away]**

```r
all_seasons %>%
  filter(HomeTeam == "Man City" | AwayTeam == "Man City") %>%


  
  
  mutate(HomeWins = if_else(HomeTeam == "Man City" & FTR == "H", "HomeWin", "NotHomeWin")) %>%
  group_by(season) %>%
  select(HomeTeam, FTR, AwayTeam, HomeWins) %>%
  count(HomeWins == "HomeWin") 
```

```
## Adding missing grouping variables: `season`
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["season"],"name":[1],"type":["chr"],"align":["left"]},{"label":["HomeWins == \"HomeWin\""],"name":[2],"type":["lgl"],"align":["right"]},{"label":["n"],"name":[3],"type":["int"],"align":["right"]}],"data":[{"1":"season1314","2":"FALSE","3":"21"},{"1":"season1314","2":"TRUE","3":"17"},{"1":"season1415","2":"FALSE","3":"24"},{"1":"season1415","2":"TRUE","3":"14"},{"1":"season1516","2":"FALSE","3":"26"},{"1":"season1516","2":"TRUE","3":"12"},{"1":"season1617","2":"FALSE","3":"27"},{"1":"season1617","2":"TRUE","3":"11"},{"1":"season1718","2":"FALSE","3":"22"},{"1":"season1718","2":"TRUE","3":"16"},{"1":"season1819","2":"FALSE","3":"20"},{"1":"season1819","2":"TRUE","3":"18"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


<<<<<<< HEAD




=======
**VI. Conclusion**
**VII. Bibliography**
>>>>>>> 5a7b550609b48d5147b802b167539539dfa5d227
