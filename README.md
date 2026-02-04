# 🧠 MRI Brain Superpixel Segmentation

## 📌 Overview

This repository provides an implementation of a **superpixel-based segmentation pipeline** for detecting and extracting **brain tumor regions** from MRI scans.

Rather than relying solely on pixel-wise models, this approach:

* Breaks the MRI image into **superpixels** (compact regions of similar intensity),
* Extracts features from these regions,
* Utilizes machine learning classification to distinguish **tumor vs healthy tissue**.

This method can improve segmentation accuracy and reduce computational complexity by working at a region level rather than individual pixels.

✨ Application Domain: **Medical image analysis — Brain tumor segmentation** <br> 
📁 Modality: MRI (Magnetic Resonance Imaging) <br>
📍 Primary Techniques: Superpixel segmentation + Machine Learning classification

---

## 📄 Reference Paper

The method implemented in this repository is derived from:

> **Automatic Brain Tumor Segmentation from Magnetic Resonance Images using Superpixel-based Approach.**
> *Details available via Springer Nature and similar academic sources.* ([Spriner Nature Paper Link](https://link.springer.com/article/10.1007/s11042-022-13166-7?utm_source=researchgate.net&utm_medium=article)) 

You should cite this method in your research if you use or build upon this code.

---

## 📦 Repository Structure

```
mri-brain-superpixel-segmentation/
├── src/                        # Source code
│   ├── superpixel_generator.m  # Generates superpixels from MRI slices
│   ├── feature_extraction.m    # Extracts features from each superpixel
│   ├── classifier_training.m   # Trains ML model on labeled superpixel data
│   ├── segmentation_predict.m  # Runs segmentation using trained model
│   └── utils/                  # Helper functions
├── data/                       # MRI data (not included)
├── README.md                   # This document
└── Automatic brain tumor segmentation from magnetic.pdf
```

---

## 🗃️ BRATS 2017 Training Dataset

For training and benchmarking segmentation algorithms, a commonly used dataset is the MICCAI BraTS 2017 dataset:

📌 BraTS 2017 Training Data
The Multimodal Brain Tumor Segmentation Challenge 2017 provides pre-operative MRI scans (T1, T1Gd, T2, FLAIR) with expert annotations for tumor regions.

🔗 Access & download:
To request and download the dataset, register and apply via the official BraTS page:
https://www.med.upenn.edu/sbia/brats2017/registration.html

💡 After requesting and being approved, you’ll receive download links for the training and validation data (including ground truth segmentations).

## 🧩 Features

✔ Superpixel segmentation to group similar pixels
✔ Extracts texture/ intensity features from regions
✔ Machine learning classifier to label tumor regions
✔ Works with MRI brain scans

---

## 🚀 Installation

This project is implemented in **MATLAB**. To run:

1. Install MATLAB (R2018b or later recommended)
2. Download or clone the repository

   ```
   git clone https://github.com/javaidiqbal11/mri-brain-superpixel-segmentation.git
   ```
3. Open the project folder in MATLAB
4. Add `src/` and utility directories to MATLAB path

---

## 🧠 Usage

### 🔹 Step 1 — Preprocess MRI Data

Convert DICOM or NIfTI MRI scans into standard 2D slices.

### 🔹 Step 2 — Generate Superpixels

Use the provided script to segment each MRI slice into superpixels.

```matlab
superpixel_generator(image_slice);
```

### 🔹 Step 3 — Extract Features

Extract quantitative features from each superpixel region:

```matlab
feature_extraction(superpixels);
```

### 🔹 Step 4 — Train Classifier

Train a supervised model (SVM, Random Forest, etc.) on available labeled datasets:

```matlab
classifier_training(features, labels);
```

### 🔹 Step 5 — Predict Segmentation

Use the trained model to classify superpixels and reconstruct brain tumor mask:

```matlab
segmentation_predict(test_features, model);
```

---

## 📊 Results

✔ Tumor segmentation mask
✔ Evaluation metrics can be computed (e.g., Dice Score, Accuracy)

> 🔎 Note: You will need labeled ground-truth masks to train and evaluate performance.

---

## 📚 Citation

If this repository or method helps your project, cite the underlying idea using the academic source below:

````
@article{superpixel_brain_seg,
  title={Automatic Brain Tumor Segmentation from Magnetic Resonance Images using Superpixel-based Approach},
  author={Muhammad Javaid Iqba, Usama Ijaz Bajwa, Aksam Iftikhar, Waqas Anwar},
  note={Available via Springer Nature Paper Link.},
  year={2022}
}
````
---


## 🤝 Contributing

Contributions are welcome! You can:

- Add training with deep learning models
- Improve feature extraction
- Integrate with U-Net or Attention U-Net pipelines
