# 🎓 Graduate Quantitative Methods

Welcome to the companion repository for Graduate Quantitative Methods, a project-based course where theory meets application. This course is designed for students ready to move beyond basic stats and explore advanced modeling with real-world social survey data. Through structured lectures, hands-on coding in Stata, and scaffolded assignments, students will build the skills necessary to conduct original research, produce journal-quality tables, and present professional-level findings.

### 🎯 Who Should Use This Repo

**Graduate students** in sociology, public health, political science, and other social sciences — particularly those planning to publish or present quantitative research.

**Educators** teaching applied quantitative methods, especially those incorporating generalized linear models (GLMs), survey data, or reproducible workflows.

---

## 🔍 Course Overview
This course helps students move beyond descriptive and linear methods, developing mastery over a range of generalized linear models (GLM). Each PowerPoint integrates theory, technical skill, and applied Stata-based examples from the GSS. Students apply this knowledge through a scaffolded sequence of assignments using their own data.

- Focus on generalized linear models (GLMs)
- Heavy emphasis on postestimation and visual interpretation
- Scaffolded assignments build toward an independent final project
- All examples use real data from the GSS dataset
- Instructional materials fully reproducible using a provided Stata .do file

<details>

<summary><strong>Students are not passive learners in this course</strong></summary>

<br>

Students begin by selecting a topic of interest and identifying a publicly available survey dataset (e.g., from [ICPSR](https://www.icpsr.umich.edu/web/pages/ICPSR/index.html)). Throughout the course:

1. **Assignments scaffold learning**: Starting with data cleaning and descriptive statistics, students build up to linear regression, then to logit, probit, and count models.
2. **Theory guides modeling**: Each assignment requires explicit theorizing, hypothesis development, and applied interpretation.
3. **Reproducible workflows**: All course examples are demonstrated using a master Stata .do file and a cleaned GSS dataset.
4. **The final paper synthesizes everything**: Students write a journal-style article and present it in class following a conference-style format.

</details>

---

## 🎓 For Students

This course is designed for graduate students who have a solid foundation in statistical reasoning and prior exposure to linear regression. By the end of the course, you will be able to:

- ✅ Apply mediation and moderation techniques using OLS
- ✅ Build and interpret generalized linear models (GLMs), including logit, probit, ologit, oprobit, multinomial logit, and count models
- ✅ Conduct and visualize postestimation analyses such as marginal effects and predicted probabilities
- ✅ Prepare publication-ready tables and figures using Stata
- ✅ Write a journal-style manuscript that integrates theory, methods, and results

---

## 🧑‍🏫 For Educators


This course provides a structured, modular approach to teaching graduate-level quantitative methods with real-world datasets and reproducible workflows in Stata. It is suitable for:

- Instructors teaching applied quantitative methods with a GLM emphasis
- Institutions with a need for reproducible research training and secondary data analysis
- Sociology, Public Health, Psychology, and Policy students

<details>

<summary><strong>🧪 Tools & Skills Taught</strong></summary>

<br>

- Data preparation and recoding in Stata
- OLS diagnostics (linearity, multicollinearity, homoscedasticity)
- Generalized Linear Models (Logit, Probit, Ordered Logit, Mlogit, Poisson, NB)
- Postestimation: odds ratios, marginal effects (AME, MEM, MER), predicted probabilities
- Mediation and moderation frameworks
- SEM concepts (introductory level)
- Academic writing and scientific communication

</details>

<details>
  
<summary><strong>🧩 Modular & Adaptable</strong></summary>

<br>

Each assignment builds on prior skills, allowing instructors to adapt the pace or depth. For example:

- Replace the GSS with your preferred dataset
- Substitute the Stata `.do` file with SPSS, SAS, R or Python equivalents
- Adjust readings or replace PPTs with custom lectures

</details>

<details>

<summary><strong>📦 What’s Included</strong></summary>

<br>

- ✅ 11 Lecture PPTs covering OLS, GLM, postestimation, and SEM
- ✅ Scaffolded assignments culminating in a journal-style final paper
- ✅ GSS dataset and corresponding Stata `.do` file used in lectures
- ✅ Presentation and paper rubrics for evaluation
- ✅ A flexible syllabus that can be adapted to quarter or semester formats

</details>

---

## ▶️ Getting Started 

👓 Just checking things out, then browse through the interactive syllabus

<details>

<summary>📚 Want to take this course or fully engage, then:</summary>

<br>

<details>
  
<summary>Review the assignments to gauge course expectations</summary>

<br>

| Assignment | Description |
|-----------|-------------|
| [Assignment 1](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/assignments/assignment_1.pdf) | Topic selection, data identification, cleaning, descriptive stats |
| [Assignment 2](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/assignments/assignment_2.pdf) | OLS modeling and diagnostics |
| [Assignment 3](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/assignments/assignment_3.pdf) | Moderation and mediation |
| [Assignment 4](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/assignments/assignment_4.pdf) | Binary logit and postestimation |
| [Assignment 5](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/assignments/assignment_5.pdf) | GLM extensions and review |
| [Final Presentation](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/assignments/FinalPresentation.pdf) | 15-min academic-style presentation |
| [Final Paper](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/assignments/FinalPaper.pdf) | Journal-style research paper using GLM |

</details>

<details>
  
<summary>Consider reading along with the assigned texts</summary>

<br>

While the course is fully accessible using the PPTs and the master Stata .do file, these texts are highly recommended:

- **Long & Freese** – *Regression Models for Categorical Dependent Variables Using Stata*
- **Hoffmann** – *Linear Regression Models: Applications and Interpretation*
- **MacKinnon, Warsi, & Dwyer (1995)** – *Mediation, Moderation, and Conditional Process*

</details>

<details>

<summary>Download the data used for applied examples in the PPTs</summary> <br>

This ZIP file contains a **Stata `.dta` dataset** used in our graduate-level quantitative methods course.

🔗 [Download GSS7218.zip](https://github.com/TonyBardo/teaching-materials/raw/main/graduate-quant/data/GSS7218.zip)

🧾 Contents: `GSS7218.dta`: A cleaned version of the General Social Survey (GSS) dataset covering years 1972–2018. 

<br>

🛠️ **Instructions to Download and Unzip**

#### 🪟 Windows
1. Click the link above or **right-click → "Save link as…"** to download the ZIP file.
2. Once downloaded, **right-click the file → "Extract All…"** to unzip it.
3. You will now see the file `GSS7218.dta` inside the extracted folder.

#### 🍎 macOS
1. Click the link or **Ctrl+Click → "Download Linked File As…"**
2. Open your **Downloads** folder and **double-click the ZIP file** to unzip it.
3. You will see the `.dta` file inside.

</details>

<details>

<summary>Actively engage with the material in the PPTs</summary>

<br>

- Replicate the applied lecture content using this master 📄[Stata .do file](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/data/master.do)

</details>

<details>

<summary>Complete the assignments, presentation, and final paper</summary>

<br>

- If you need help finding data to use for asignments, then consider checking [here](https://www.icpsr.umich.edu/web/pages/ICPSR/index.html)

</details>

</details>

---

<details>
  
  <summary><strong>📅 Interactive Syllabus</strong></summary>

<br>
  
| **Week** | **Topic** | **Slides** | **Readings / Due** |
|---|---|---|---|
| Week 1 | Course Intro & Refresher | [PPT 1](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/PPTs/PPT-1-graduate-quant.pdf) | Long & Freese Ch. 1, Pre-assessment |
| Week 2 | Practice Stata | — | [UCLA Stata Resources](https://stats.idre.ucla.edu/stata/), [Assignment 1](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/assignments/assignment_1.pdf) |
| Week 3 | Visualization & Model Thinking | [PPT 2](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/PPTs/PPT-2-graduate-quant.pdf) | Long & Freese Ch. 2 |
| Week 4 | Linear Regression Diagnostics | [PPT 3](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/PPTs/PPT-3-graduate-quant.pdf) | Hoffmann Ch. 1, [Assignment 2](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/assignments/assignment_2.pdf) |
| Week 5 | Mediation vs Moderation | [PPT 4](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/PPTs/PPT-4-graduate-quant.pdf) | MacKinnon et al. (1995), Hoffmann Ch. 2, [Assignment 3](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/assignments/assignment_3.pdf) |
| Week 6 | Intro to GLM | [PPT 5](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/PPTs/PPT-5-graduate-quant.pdf) | Long & Freese Ch. 3 & 4 |
| Week 7 | Binary Outcomes (Logit/Probit) | [PPT 6](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/PPTs/PPT-6-graduate-quant.pdf) | Hoffmann Ch. 3, Long & Freese Ch. 5 & 6, [Assignment 4](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/assignments/assignment_4.pdf) |
| Week 8 | Ordered Outcomes | [PPT 7](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/PPTs/PPT-7-graduate-quant.pdf) | Hoffmann Ch. 4, Long & Freese Ch. 7 |
| Week 9 | Review: Binary & Ordered Models | [PPT 8](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/PPTs/PPT-8-graduate-quant.pdf) | Review, [Assignment 5](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/assignments/assignment_5.pdf) |
| Week 10 | Multinomial Logit | [PPT 9](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/PPTs/PPT-9-graduate-quant.pdf) | Hoffmann Ch. 5, Long & Freese Ch. 8 |
| Week 11 | Count Models (Poisson, NegBin) | [PPT 10](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/PPTs/PPT-10-graduate-quant.pdf) | Hoffmann Ch. 6, Long & Freese Ch. 9 |
| Week 12 | Structural Equation Modeling (Intro) | [PPT 11](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/PPTs/PPT-11-graduate-quant.pdf) | Catch-up |
| Week 13 | Student Presentations | — | [Final Presentation Instructions](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/assignments/FinalPresentation.pdf) |
| Week 14 | Final Projects | — | [Final Paper Instructions](https://github.com/TonyBardo/teaching-materials/blob/main/graduate-quant/assignments/FinalPaper.pdf) |

</details>

---

## 🗂️ Repository Structure

| Folder | Description |
|--------|-------------|
| [`/PPTs`](https://github.com/TonyBardo/teaching-materials/tree/main/graduate-quant/PPTs) | Eleven instructor-designed slide decks integrating theory, model-building, and postestimation using applied Stata examples from the GSS. |
| [`/assignments`](https://github.com/TonyBardo/teaching-materials/tree/main/graduate-quant/assignments) | Scaffolded assignment prompts and grading criteria that guide students through topic selection, GLM modeling, and journal-style writing. Includes the final paper and presentation instructions. |
| [`/data`](https://github.com/TonyBardo/teaching-materials/tree/main/graduate-quant/data) | Contains the cleaned **General Social Survey (GSS)** dataset (`GSS7218.dta`) and the corresponding **Stata master `.do` file** used to replicate all examples in the lecture slides. |
