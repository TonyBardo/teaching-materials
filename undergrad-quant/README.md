# 🎓 Undergraduate Quantitative Methods

Welcome to the companion repository for *Introduction to Quantitative Methods*, an undergraduate course that blends theory, measurement, and applied statistics using R. This course is organized around a semester-long consulting simulation, giving students hands-on experience with real and synthetic survey data.

🎯 **Audience**: Undergraduate students (especially social sciences) and educators interested in adopting a critical and applied approach to teaching methods.

---

## 🔍 Course Overview

> “Teaching quantitative methods without emphasizing perspective and theory would be like teaching you to drive with your eyes closed.”

This course goes beyond formulas and software. Students will:
- Investigate how problems are framed and measured in science
- Build, test, and evaluate hypotheses from theory to application
- Use RStudio to clean, explore, and model data
- Simulate real-world work as consultants for Netflix

Throughout the course, students critically explore how perspective, theory, and measurement shape how we understand and solve problems with data.

<details>
<summary><strong>Comprehensive list of student learning objectives</strong></summary><br>
  
**1. Develop a Critical Understanding of Quantitative Inquiry**
- Recognize that science is not neutral but shaped by theory, perspective, and framing.
- Understand how social problems are defined, studied, and “solved” differently depending on theoretical orientation.
- Explain the role of theory in formulating propositions, research questions, and hypotheses.

**2. Master Research Design & Measurement**
- Conceptualize abstract constructs into researchable variables.
- Operationalize variables with clarity and precision, paying close attention to level of measurement.
- Build hypotheses that are logically sound and empirically testable.

**3. Apply Core Statistical Tools**
- Use descriptive statistics to summarize data and begin exploring relationships.
- Differentiate between central tendency (PPT-5) and variability (PPT-6) and know when each is most relevant.
- Classify and select statistical methods based on variable type and research goals.

**4. Understand Probability, Sampling, and Uncertainty**
- Grasp the implications of random sampling and how it introduces uncertainty.
- Use the Central Limit Theorem to understand how sample statistics behave across repeated samples (PPTs 7–8).
- Quantify uncertainty with standard error and margin of error, laying the foundation for inferential analysis.

**5. Conduct and Interpret Inferential Statistics**
- Estimate confidence intervals and interpret their meaning in relation to sampling variability (PPTs 9–14).
- Conduct hypothesis tests (t-tests, chi-squared tests) using both hand calculations and R.
- Interpret p-values, critical values, and statistical significance while always keeping the larger research context in view.

**6. Explore and Model Complex Relationships**
- Use bivariate visualizations and statistical tests to explore relationships across variable types (Exercise 7).
- Build, interpret, and critique linear regression models—including models with multiple predictors and interaction terms (Exercise 8).
- Evaluate whether results are both statistically significant and substantively meaningful.

**7. Gain Technical Fluency in R**
- Clean, code, and analyze survey data using reproducible workflows.
- Debug and interpret R scripts for data preparation, hypothesis testing, and regression modeling.
- Annotate code for transparency and communicate insights effectively in collaborative settings.

**8. Work as a Data Team**
- Collaborate with peers in a semester-long simulation project, practicing role delegation, documentation, and constructive feedback.
- Present analyses and conclusions as if advising a real client (Netflix).
- Build habits of clear communication, peer review, and integrity in applied data work.

</details>

<details>
  
<summary><strong>Detailed student expereince narrative</strong></summary>

This course provides a theory-informed, hands-on introduction to quantitative reasoning grounded in sociological thinking and real-world problem solving. Students begin by engaging in a foundational series of four conceptual PowerPoints that reframe science as a perspective-driven process rather than a search for universal truths.

In PPTs 1–3, students learn how theory frames problems and guides every step of the research process, from hypothesis formation to measurement and method.

In PPT-4, these concepts are synthesized into a shared model of the scientific process—one that guides the rest of the course.

From there, PPTs 5–6 introduce descriptive statistics as critical first steps in assessing whether our data are meaningful and usable. Students learn why level of measurement matters, and how choices made during conceptualization constrain which statistical tools are valid.

In PPTs 7–8, students explore sampling theory and the Central Limit Theorem, learning why sample estimates can’t be trusted blindly. This prepares them to understand standard error, margin of error, and why inferential statistics are needed.

Finally, PPTs 9–14 take a stepwise approach through the logic of inferential statistics, with an emphasis on confidence intervals and hypothesis testing that culminates in a set of tools that let students evaluate the precision and reliability of their sample estimates in relation to broader populations.

These lectures are directly connected to a master R script, which allows students to follow along, reproduce applied GSS-based examples, and later adapt them to their own simulated Netflix dataset.

🌐 The Netflix Simulation
In tandem with lectures, students work in teams to complete a series of applied exercises based on a Netflix consulting scenario. These exercises take students from theory and hypothesis (Exercises 1–2) through data cleaning (Exercise 3), descriptive analysis (Exercise 4), simulation and sampling distributions (Exercises 5–6), precision and hypothesis testing (PPT 11), bivariate relationships (Exercise 7), and finally multivariate regression and moderation modeling (Exercise 8).

Students write, execute, and modify R code for each stage-building confidence, competence, and a portfolio of applied, team-based analysis.

</details>

---

## 🎓 For Students
**If you're considering this course, here's what you'll get:**

✅ **Learn by doing**, not memorizing equations  
✅ **Team-based simulation** with a real-world feel  
✅ **Build critical thinking** by connecting theory, measurement, and data  
✅ **Finish with reproducible workflows** and a working knowledge of R
✅ **No prior R experience needed**  

---

## 🧑‍🏫 For Educators
**These materials are open for use, remixing, and adaptation. This course was built with:**

- A single master 📄[R script](./data/RScript_GSS.R) that students use to follow and replicate applied lecture content
- A clean analyses-ready 💾[GSS dataset](./data/GSS.RData) for general-purpose learning, and
- A fully designed simulation including a student-designed Qualtrics survey, coding templates, and reproducible analysis

**Each lecture and exercise is fully scaffolded with:**
- Clear learning objectives
- Real-world relevance
- Applied statistical programming
- Alignment between theory and analysis

---

# ▶️ Getting Started

👓 Just checking things out, then browse through the interactive syllabus

<details>
  
 <summary>📚 Want to take this course or fully engage, then:</summary>
 
#### Follow along with the interactive syllabus
 - Actively engage with the material in the PPTs
    - Download the 💾[GSS dataset](./data/GSS.RData) used to generate applied lecture content  
    - Replicate the applied lecture content using this master 📄[R script](./data/RScript_GSS.R)
  
  - Complete the  simulation exercises
    - Supplemental 💾 datasets and 📄R scripts provided
    - Accessible within the interactive syllabus
 
⚠️ Required software: **RStudio** [(download here if needed)](https://posit.co/download/rstudio-desktop/)
  - In case you need some help downloading **RStudio** [click here](./data/RStudio_Help.pdf)
    - The help document uses this  💾[practice dataset](./data/Class_Data_S2025.xlsx)

</details>

---

<details>
  
  <summary><strong>📅 Interactive Syllabus</strong></summary>

### Week 1 – Getting Critical with the Scientific Process
- **Day 1**: [PPT 1 – Scientific perspectives and theories](./PPTs/PPT-1-Undergrad-Quant.pdf)
- **Day 2**: [PPT 2 – Hypotheses and conceptualization](./PPTs/PPT-2-Undergrad_Quant.pdf)

### Week 2 – Scientific Process, Continued
- **Day 3**: [PPT 3 – Operationalization](./PPTs/PPT-3-Undergrad-Quant.pdf)
- **Day 4**: [PPT 4 – Study design and data](./PPTs/PPT-4-Undergrad-Quant.pdf)

### Week 3 – Real-World Application
- **Day 5**: [Exercise 1 – Identifying stakeholder needs](./exercises/ex_1_instructions.pdf)
- **Day 6**: [Exercise 2 – Measuring stakeholder needs](./exercises/ex_2_instructions.pdf)

### Week 4 – Descriptive Statistics
- **Day 7**: [PPT 5 – Central Tendency](./PPTs/PPT-5-Undergrad-Quant.pdf)
- **Day 8**: [PPT 5 – Central Tendency with R](./PPTs/PPT-5-Undergrad-Quant.pdf)

### Week 5 – Descriptive Statistics, Continued
- **Day 9**: [PPT 6 – Dispersion](./PPTs/PPT-6-Undergrad-Quant.pdf)
- **Day 10**: [PPT 6 – Dispersion with R](./PPTs/PPT-6-Undergrad-Quant.pdf)

### Week 6 – Descriptive Statistics: Application
- **Day 11**: [Exercise 3 – Preparing Data](./exercises/ex_3_instructions.pdf)  
               → [Original Qualtrics Survey](https://uky.az1.qualtrics.com/jfe/form/SV_bIx3tfhTD55tMI6)
- **Day 12**: [Exercise 4 – Summarizing Data](./exercises/ex_4_instructions.pdf)  
  📄[R Script](./exercises/ex_4_Rscript.R) 💾[R Dataset](./exercises/netflix_survey.RData)

### Week 7 – Inferential Statistics: Abstract
- **Day 13**: [PPT 7 – Probability](./PPTs/PPT-7-Undergrad-Quant.pdf)
- **Day 14**: [PPT 7 – Central Limit Theorem](./PPTs/PPT-7-Undergrad-Quant.pdf)

### Week 8 – Abstraction Clarified
- **Day 15**: [Exercise 5 – Sampling Prequel](./exercises/ex_5_preface.pdf)
- **Day 16**: [Exercise 5 – Coin Flip Sampling](./exercises/ex_5_Instructions.pdf)  
  📄[R Script](./exercises/ex_5_Rscript.R)

### Week 9 – Confidence Intervals
- **Day 17**: [PPT 8 – Confidence Intervals Intro](./PPTs/PPT-8-Undergrad-Quant.pdf)
- **Day 18**: [PPT 9 – Confidence Intervals Revisited](./PPTs/PPT-9-Undergrad-Quant.pdf)

### Week 10 – Hypothesis Testing
- **Day 19**: [PPT 10 – Hypothesis Testing](./PPTs/PPT-10-Undergrad-Quant.pdf)
- **Day 20**: [Exercise 6 – Sample Quality Assessment](./exercises/ex_6_instructions.pdf)  
  📄[R Script](./exercises/ex_6_Rscript.R)

### Week 11 – CIs & Hypothesis Testing: Real-World App
- **Day 21**: [PPT 11 Instructions – Competing Firm Analysis](./PPTs/PPT-11-instructions.pdf)  
  📄[R Script](./PPTs/PPT-11-Rscript.R)
- **Day 22**: [PPT 11 – Univariate vs Bivariate](./PPTs/PPT-11-Undergrad_Quant.pdf)

### Week 12 – Inferential Stats: Bivariate
- **Day 23**: [Exercise 7 – Exploratory Analysis](./exercises/ex_7_instructions.pdf)  
  📄[R Script](./exercises/ex_7_Rscript.R) 💾[R Dataset](./exercises/netflix_survey.RData)
- **Day 24**: [PPT 12 – ANOVA and Pearson’s r](./PPTs/PPT-12-Undergrad-Quant.pdf)

### Week 13 – Simple Linear Regression
- **Day 25**: [PPT 13 – Linear Regression: Modeling](./PPTs/PPT-13-Undergrad-Quant.pdf)
- **Day 26**: [PPT 13 – Linear Regression: Interpretation](./PPTs/PPT-13-Undergrad-Quant.pdf)

### Week 14 – Multivariate Regression: Application
- **Day 27**: [PPT 14 – Multivariate Regression](./PPTs/PPT-14-Undergrad-Quant.pdf)
- **Day 28**: [Exercise 8 – MLR with Augmented Netflix Data](./exercises/ex_8_instructions.pdf)  
  📄[R Script](./exercises/ex_8_RScript.R) 💾[R Dataset Augmented](./exercises/Netflix_1000.RData)

</details>

---

## 🗂️ Repository Structure

| Folder | Description |
|--------|-------------|
| [`/PPTs`](https://github.com/TonyBardo/teaching-materials/tree/main/undergrad-quant/PPTs) | Fourteen instructor-designed lectures covering theory, measurement, probability, and inference. Each slide deck builds toward applied data analysis. |
| [`/data`](https://github.com/TonyBardo/teaching-materials/tree/main/undergrad-quant/data) | Contains the **General Social Survey (GSS)** example data, the **Netflix Qualtrics survey data**, an **augmented synthetic dataset**, and the **master R script** used across all PowerPoint examples. |
| [`/exercises`](https://github.com/TonyBardo/teaching-materials/tree/main/undergrad-quant/exercises) | Eight applied in-class team-based exercises, each with supporting R scripts, handouts, and datasets. Exercises follow a consulting project storyline. |

---
