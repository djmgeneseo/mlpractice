//
//  DemoIngredients.swift
//  mlpractice
//
//  Created by David Nyman on 10/10/18.
//  Copyright © 2018 David. All rights reserved.
//

import Foundation
import UIKit

struct list {
    public static var jsonString: String = """
[
{
"ingredient": "Vitis Vinifera (Grape) Seed Oil",
"synonyms": "Grape Seed Oil",
"ingredient_tag": "antioxidant, emollient",
"1_sentence_description": "An oil that will make your skin smooth and helps dry skin, contains a whole bunch of linoleic acid (a type of fatty acid) and vitamin E. A good oil for oily skin and acne!"
},
{
"ingredient": "Camellia Oleifera Seed Oil",
"synonyms": "Tea Seed Oil",
"ingredient_tag": "emollient",
"1_sentence_description": "This plant oil is a great emollient for dry skin that contains oleic acid, squalene, and vitamin E (Fun Fact you can also cook with this oil)"
},
{
"ingredient": "Prunus Amygdalus Dulcis (Sweet Almond) Oil",
"synonyms": "",
"ingredient_tag": "emollient",
"1_sentence_description": "This oil made from almonds is a great at making your skin smooth and contains oleic acid and linoleic acid (some dope fatty acids)."
},
{
"ingredient": "Rosmarinus Officinalis (Rosemary) Leaf Extract",
"synonyms": "",
"ingredient_tag": "antioxidant, soothing, antimicrobial/antibacterial",
"1_sentence_description": "From the yummy herb we cook with, this plant most notably contains rosmarinic acid (antioxidant), but it also does contain some essential oil and fragrance"
},
{
"ingredient": "Vaccinium Macrocarpon (Cranberry) Seed Oil",
"synonyms": "",
"ingredient_tag": "emollient",
"1_sentence_description": "This oil made from cranberries has a bunch of fatty acids (linolenic acid and linoleic acid AND oleic acid) that is going to make your skin soft as hell."
},
{
"ingredient": "Tocopheryl Acetate",
"synonyms": "Vitamin E Acetate",
"ingredient_tag": "antioxidant",
"1_sentence_description": "A type of Vitamin E, and most commonly used in skincare due to it's longer shelf life and antioxident properties, but it might not work as well as pure Vitamin E%u2026"
},
{
"ingredient": "Tocopherol",
"synonyms": "Vitamin E",
"ingredient_tag": "antioxidant",
"1_sentence_description": "#Boss Alert: 1 of only 4 fat soluble vitamins, it's both a moisturizing ingredient and a superstar antioxident!"
},
{
"ingredient": "Ascorbyl Tetraisopalmitate",
"synonyms": "Vitamin C",
"ingredient_tag": "antioxidant",
"1_sentence_description": "A type of Vitamin C that is oil soluble (it can be in oil based products), and is considered to be less harsh. It's a superstar antioxidant, and works best in the presence of Vitamin E."
},
{
"ingredient": "Parfum (Fragrance)",
"synonyms": "",
"ingredient_tag": "perfuming",
"1_sentence_description": "The catch all term for everything that makes a product smell good (or not depending on your jam). Be weary using products with fragrance if you have sensitive skin."
},
{
"ingredient": "BHT",
"synonyms": "Butylated Hydroxy Toluene",
"ingredient_tag": "antioxidant, preservative",
"1_sentence_description": "A preservative that was controversial for a hot minute because people thought it was a carcinogen, but all studies conducted looked at what happened when you take high doeses of BHT orally.  This ingredient is ultimately totally safe to use topically in your skincare."
},
{
"ingredient": "Linalool",
"synonyms": "",
"ingredient_tag": "perfuming",
"1_sentence_description": "Super common fragrance. Be weary using products with fragrance if you have sensitive skin"
},
{
"ingredient": "Limonene",
"synonyms": "",
"ingredient_tag": "perfuming, solvent, deodorant",
"1_sentence_description": "Super common fragrance found in various herbs. Be weary using products with fragrance if you have sensitive skin"
},
{
"ingredient": "Citral",
"synonyms": "",
"ingredient_tag": "perfuming",
"1_sentence_description": "Super common fragrance found in citrus. Be weary using products with fragrance if you have sensitive skin"
},
{
"ingredient": "Coumarin",
"synonyms": "",
"ingredient_tag": "perfuming",
"1_sentence_description": "Super common fragrance that smells vanilla-y. Be weary using products with fragrance if you have sensitive skin"
},
{
"ingredient": "Geraniol",
"synonyms": "",
"ingredient_tag": "perfuming",
"1_sentence_description": "Super common fragrance that smells like rose. Be weary using products with fragrance if you have sensitive skin"
},
{
"ingredient": "Aqua (Water)",
"synonyms": "",
"ingredient_tag": "solvent",
"1_sentence_description": "#Boss Alert: Water is used to dissolve other ingredients and is super duper common in skincare (obviously)."
},
{
"ingredient": "Niacinamide",
"synonyms": "Nicotinamide, Vitamin B3, Niacin",
"ingredient_tag": "cell-communicating ingredient, skin brightening, antiacne, moisturizer/humectant",
"1_sentence_description": "#Boss Alert: Niacinamide (or vitamin B3) can help reduce skin water loss, reduce the apperance of fine lines and wrinkles, brighten skin, AND reduce the appearence of pores. Basically... it does it all."
},
{
"ingredient": "Pentylene glycol",
"synonyms": "",
"ingredient_tag": "solvent, moisturizer/humectant",
"1_sentence_description": "Stabilizes skincare forumlations and moisturizes your skin."
},
{
"ingredient": "Zinc PCA",
"synonyms": "",
"ingredient_tag": "antiacne, moisturizer/humectant",
"1_sentence_description": "If you need to soothe your skin and regulate your sebum production, this ingredient is for you (especially if you have oily skin)"
},
{
"ingredient": "Dimethyl Isosorbide",
"synonyms": "",
"ingredient_tag": "solvent, viscosity controlling",
"1_sentence_description": "Helps in the delivery of active ingredients (the ingredients in products that are hopefully giving you the results you want)"
},
{
"ingredient": "Tamarindus Indica Seed Gum",
"synonyms": "",
"ingredient_tag": "moisturizer/humectant",
"1_sentence_description": "A moistuizer from a tree in the bean family"
},
{
"ingredient": "Xanthan Gam",
"synonyms": "",
"ingredient_tag": "viscosity controlling",
"1_sentence_description": "Makes your products #thick"
},
{
"ingredient": "Isoceteth-20",
"synonyms": "",
"ingredient_tag": "emulsifying, surfactant/cleansing",
"1_sentence_description": "Helps water-loving ingredients and oil-loving ingredients coexist in perfect harmony"
},
{
"ingredient": "Ethoxydiglycol",
"synonyms": "",
"ingredient_tag": "solvent",
"1_sentence_description": "Helps in the delivery of \"active\" ingredients (the ingredients in products that are hopefully giving you the results you want)"
},
{
"ingredient": "Phenoxyethanol",
"synonyms": "",
"ingredient_tag": "preservative",
"1_sentence_description": "A common preservative that is totally save to use topically in the normal, low concertration (1% or lower) that is the standard in skincare. It is also used frequently in formulations with Ethylhexylglycerin."
},
{
"ingredient": "Chlorphenesin",
"synonyms": "",
"ingredient_tag": "preservative, antimicrobial/antibacterial",
"1_sentence_description": ""
},
{
"ingredient": "Glycerin",
"synonyms": "Glycerol",
"ingredient_tag": "skin-identical ingredient, moisturizer/humectant",
"1_sentence_description": "#Boss Alert: Dry skin's sworn enemy, this is a superstar hydrator and is also naturally found in our skin's outer layer (aka a \"skin-identical\" ingredient)"
},
{
"ingredient": "Trehalose",
"synonyms": "",
"ingredient_tag": "moisturizer/humectant",
"1_sentence_description": "A sugar that keeps your skin hydrated #sweeeeet"
},
{
"ingredient": "Chondrus Crispus (Carrageenan) Extract",
"synonyms": "Seaweed Extract",
"ingredient_tag": "moisturizer/humectant",
"1_sentence_description": "A hydrating ingredient from red seaweed."
},
{
"ingredient": "Coffea Arabica (Coffee) Extract",
"synonyms": "Coffea Arabica Extract, Coffea Arabica (Coffee) Fruit Extract",
"ingredient_tag": "antioxidant",
"1_sentence_description": "Our drink of choice every morning but now in your skincare. The fruit from the coffee plant contains a bunch of ferulic acid, which is a superstar antioxidant."
},
{
"ingredient": "Cyclodextrin",
"synonyms": "",
"ingredient_tag": "chelating, absorbent/mattifier",
"1_sentence_description": ""
},
{
"ingredient": "Sodium Hyaluronate",
"synonyms": "",
"ingredient_tag": "skin-identical ingredient, moisturizer/humectant",
"1_sentence_description": "Hyaluronic acid's more stable sister, this ingredient packs the same punch by keeping your skin hydrated."
},
{
"ingredient": "Sodium PCA",
"synonyms": "",
"ingredient_tag": "skin-identical ingredient, moisturizer/humectant",
"1_sentence_description": "Keeps your skin hydrated."
},
{
"ingredient": "Urea",
"synonyms": "Carbamide",
"ingredient_tag": "skin-identical ingredient, moisturizer/humectant",
"1_sentence_description": "Found in both urine (gross) and your skin (nice), this hydrating ingredient can double as a gentle exfoliant which makes it a powerful weapon against dryness."
},
{
"ingredient": "Polyquatemium-51",
"synonyms": "",
"ingredient_tag": "viscosity controlling",
"1_sentence_description": ""
},
{
"ingredient": "Triacetin",
"synonyms": "",
"ingredient_tag": "antimicrobial/antibacterial, solvent",
"1_sentence_description": ""
},
{
"ingredient": "Cocos Nucifera (Coconut) Water",
"synonyms": "Coconut Liquid Endosperm",
"ingredient_tag": "moisturizer/humectant",
"1_sentence_description": "Coconut Water! Super hydrating, since it is almost all just regular H2O, with some vitamins and minerals thrown in"
},
{
"ingredient": "Coceth-7",
"synonyms": "",
"ingredient_tag": "emulsifying, surfactant/cleansing",
"1_sentence_description": "Helps water-loving ingredients and oil-loving ingredients coexist in perfect harmony"
},
{
"ingredient": "PPG-1-PEG-9 Lauryl Glycol Ether",
"synonyms": "",
"ingredient_tag": "emulsifying, surfactant/cleansing",
"1_sentence_description": "Helps water-loving ingredients and oil-loving ingredients coexist in perfect harmony"
},
{
"ingredient": "PEG-40 Hydrogenated Castor Oil",
"synonyms": "",
"ingredient_tag": "emulsifying, surfactant/cleansing",
"1_sentence_description": "Helps water-loving ingredients and oil-loving ingredients coexist in perfect harmony"
},
{
"ingredient": "Disodium EDTA",
"synonyms": "",
"ingredient_tag": "chelating, viscosity controlling",
"1_sentence_description": ""
},
{
"ingredient": "Caprylyl Glycol",
"synonyms": "",
"ingredient_tag": "moisturizer/humectant, emollient",
"1_sentence_description": "Keeps your skin hydrated but can also have anti-microbial activities."
},
{
"ingredient": "Ethylhexylglycerin",
"synonyms": "",
"ingredient_tag": "preservative",
"1_sentence_description": "A common preservative that is often put in formulations with phenoxyethanol (another preservative) to enhance phenoxyethanol's efficacy."
},
{
"ingredient": "Fragrance (Parfum)",
"synonyms": "",
"ingredient_tag": "perfuming",
"1_sentence_description": "The catch all term for everything that makes a product smell good (or not depending on your jam). Be weary using products with fragrance if you have sensitive skin."
},
]
"""

}
