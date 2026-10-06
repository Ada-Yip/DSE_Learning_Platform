INSERT INTO topic_skills (
  subject, topic, skill_name,
  description, question_pattern, common_traps, example_prompt
) VALUES (
  'math',
  'estimation_and_errors',
  'basic_rounding',
  
  $$Questions that test rounding a number to a specified precision. 
Students must round to nearest unit, decimal places, or significant 
figures. Tests understanding of place value and rounding rules.$$,
  
  $$Part (a): Round to nearest [unit]
Part (b): Round to [N] decimal places
Part (c): Round to [N] significant figures
Total: 3 marks. Point marking (independent parts).$$,
  
  $$1. Confusing decimal places with significant figures
2. Forgetting that round up / round down / round off are different
3. Not mixing directions correctly when question asks for "round up"
4. For leading zeros: 0.0567 to 2 s.f. is 0.057, not 0.05$$,
  
  $$You are a DSE Mathematics examiner. Generate a basic rounding question.

Requirements:
- Pick a base number with 3-5 significant figures
- Use a NEW number, NOT the same as past paper numbers
- Avoid: 405.504, 8091.1908, 123.45, 265.473, 534.7698
- Structure: 3 parts (a, b, c)
- Part (a): nearest unit / ten / hundred / thousand
- Part (b): 1-3 decimal places
- Part (c): 1-3 significant figures
- Mix rounding directions: at least one UP, one DOWN, one OFF
- Total 3 marks (1 mark per part)

Output ONLY valid JSON, no markdown code fence:
{
  "question": "...",
  "answer": "...",
  "explanation": "..."
}$$ 
)
ON CONFLICT (subject, topic, skill_name) 
DO UPDATE SET
  description = EXCLUDED.description,
  question_pattern = EXCLUDED.question_pattern,
  common_traps = EXCLUDED.common_traps,
  example_prompt = EXCLUDED.example_prompt;

SELECT skill_name, description FROM topic_skills;

INSERT INTO topic_skills (
  subject, topic, skill_name,
  description, question_pattern, common_traps, example_prompt
) VALUES (
  'math',
  'estimation_and_errors',
  'error_analysis',
  
  $$Questions that require students to compute bounds from a measurement 
and verify whether a claimed total is possible. Tests understanding of 
"correct to the nearest X" meaning ±(X/2), and scaling of errors.$$,
  
  $$Part (a): "Find the least/greatest possible [property] of [item]"
Part (b): "Is it possible that [N items total VALUE] measured as 
[MEASURED] correct to [TOLERANCE]? Explain."
Total: 4-5 marks. Chain marking (b depends on a).$$,
  
  $$1. Forgetting to divide the precision by 2 (answer X instead of X/2)
2. For N items, applying error once instead of scaling by N
3. Not showing both methods of verification
4. Confusing < and <= at boundaries
5. Not reading "correct to the nearest 0.1 kg" as ±0.05 kg$$,
  
  $$You are a DSE Mathematics examiner. Generate an error analysis question.

Requirements:
- Pick a realistic item from: salt pack, bottle, wire, or new item
- Measurement format: "X correct to the nearest Y"
- Part (a): ask for least OR greatest possible value
- Part (b): ask "Is it possible that N items total VALUE measured as 
  MEASURED correct to TOLERANCE?"
- The answer should be NO (following 2013, 2017 pattern)
- Require student to show TWO methods of verification
- Total 4-5 marks

Avoid these past paper items:
- 100g sea salt pack (2013)
- 200mL bottle (2017)
- 5cm metal wire (2007)

Output ONLY valid JSON, no markdown code fence:
{
  "question": "...",
  "answer": "full solution with Method 1 and Method 2",
  "explanation": "mark scheme breakdown"
}$$ 
)
ON CONFLICT (subject, topic, skill_name) 
DO UPDATE SET
  description = EXCLUDED.description,
  question_pattern = EXCLUDED.question_pattern,
  common_traps = EXCLUDED.common_traps,
  example_prompt = EXCLUDED.example_prompt;


INSERT INTO topic_skills (
  subject, topic, skill_name,
  description, question_pattern, common_traps, example_prompt
) VALUES (
  'math',
  'estimation_and_errors',
  'real_world_application',
  
  $$Questions that use rounding as a strategy to estimate a total or 
check feasibility. Tests understanding of why rounding UP gives an 
upper-bound estimate and rounding DOWN gives a lower-bound estimate.$$,
  
  $$Part (a): "Estimate total by rounding [UP/DOWN] each [item/amount] 
to nearest [unit]"
Part (b): "Will they have enough / Is constraint satisfied? Use result 
from (a) to explain."
Total: 5-6 marks. Mixed marking.$$,
  
  $$1. Confusing the direction: round UP makes estimate HIGHER than actual; 
   round DOWN makes estimate LOWER than actual
2. Not connecting part (b) to part (a): students must cite the estimate 
   and the rounding direction
3. Using wrong comparison operator (< vs >) when concluding
4. Forgetting "explain" means stating the actual vs estimate relationship$$,
  
  $$You are a DSE Mathematics examiner. Generate a real-world application 
question.

Requirements:
- Pick a scenario: purchasing items, or group money pooling
- Specify a rounding direction (UP or DOWN)
- Part (a): estimate total by rounding each value in the specified direction
- Part (b): decision question with "Explain your answer"
- The decision must rely on the direction:
  * If round UP: actual < estimate, so estimate below budget → YES safe
  * If round DOWN: actual > estimate, so estimate above budget → NO
- Total 5-6 marks

Avoid replicating Q1.3 (biscuits/chocolate/drinks) and Q1.5 (Peter/John/Henry).

Output ONLY valid JSON, no markdown code fence:
{
  "question": "...",
  "answer": "...",
  "explanation": "..."
}$$ 
)
ON CONFLICT (subject, topic, skill_name) 
DO UPDATE SET
  description = EXCLUDED.description,
  question_pattern = EXCLUDED.question_pattern,
  common_traps = EXCLUDED.common_traps,
  example_prompt = EXCLUDED.example_prompt;

SELECT skill_name, 
       LENGTH(description) AS desc_len,
       LENGTH(example_prompt) AS prompt_len
FROM topic_skills 
ORDER BY skill_name;