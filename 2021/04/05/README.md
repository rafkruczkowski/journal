# CW14 04/05 Monday - Linear Algebra
---
Adding vectors
```
def vector_add(v, w)
   return[v_i + w_i
          for v_i, w_i, in zip(v,w)]
```
Summing up vectors
```
def vector_sum(vectors):
   results = vectors[0]
   for vector in vectors[1:]:
      results = vector_add(results, vector)
   return results
```



---
[Link to ToC](https://github.com/rafkruczkowski/journal)