# HELP

Lines ← 1↓(¬×1+`⊢)∘(10=@-˜⊢)⊸⊔

# DAY 1

Day01Part1 ← {
	elves ← •BQN⚇1 1↓(¬×1+`⊢)∘(0=≠¨)⊸⊔ Lines 𝕩
	⌈´ +´¨ elves
}

Day01Part2 ← {
	elves ← •BQN⚇1 1↓(¬×1+`⊢)∘(0=≠¨)⊸⊔ Lines 𝕩
	+´ 3↑ ∨ +´¨ elves
}

###

solutions ← [
	Day01Part1∘⊣, Day01Part2∘⊣,
]

day‿part‿file ← •args
•Show (•FChars file) ⊢◶solutions (2 × (•BQN day) - 1) + (•BQN part) - 1