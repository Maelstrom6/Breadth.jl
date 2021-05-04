append!(truths, [
    Axiom("Definition of the universal set", P ⊂ Ω, TRUE),
    Axiom("Definition of the universal set", x ∈ Ω, TRUE),
    Axiom("Definition of the empty set", ∅ ⊂ A, TRUE),
    Axiom("Definition of the empty set", x ∈ ∅, FALSE),
    Axiom("Equal sets are subsets", A ⊂ A, TRUE),

    Axiom("Definition of Element Of", x ∈ (A ∩ B), (x ∈ A) ∧ (x ∈ B)),
    Axiom("Definition of Element Of", (x ∈ A) ∧ (x ∈ B), x ∈ (A ∩ B)),
    Axiom("Definition of Element Of", x ∈ (A ∪ B), (x ∈ A) ∨ (x ∈ B)),
    Axiom("Definition of Element Of", (x ∈ A) ∨ (x ∈ B), x ∈ (A ∪ B)),

    Axiom("Flatten Condition Set", ConditionSet(y, y ∈ A), A),  # todo: change to f(x)
    Axiom("Expand Condition Set", A, ConditionSet(_y, _y ∈ A)),  # todo: change to f(x)
    Axiom("Definition of Subset", A ⊂ B, (_y ∈ A) ⟹ (_y ∈ B)),
    Axiom("Definition of Subset", (_y ∈ A) ⟹ (_y ∈ B), A ⊂ B),

    Axiom("Definition of the universal set", x ∈ (P ∪ Ω), x ∈ Ω),

    Theorem("Intersections are subsets of Unions", x ∈ (A ∩ B), x ∈ (A ∪ B), Proof([])),
    Theorem("Intersections are subsets of Unions", (A ∩ B) ⊂ (A ∪ B), TRUE, Proof([])),
])
