import { supabase } from "@/lib/supabase";

export async function POST(request: Request) {
  const body = await request.json();
  const { topic, skill } = body;
  
  // Read skills from database
  const { data: skillData, error: skillError } = await supabase
    .from("topic_skills")
    .select("*")
    .eq("topic", topic)
    .eq("skill_name", skill)
    .maybeSingle();
  
  if (skillError) {
    return Response.json(
      { error: skillError.message },
      { status: 500 }
    );
  }
  
  if (!skillData) {
    return Response.json(
      { error: `Skill not found: ${topic} / ${skill}` },
      { status: 404 }
    );
  }
  
  // Generate Questions with AI
  const aiResponse = await fetch(
    "https://openrouter.ai/api/v1/chat/completions",
    {
      method: "POST",
      headers: {
        Authorization: `Bearer ${process.env.OPENROUTER_API_KEY}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        model: "nvidia/nemotron-3-nano-omni-30b-a3b-reasoning:free",
        messages: [
          { role: "user", content: skillData.example_prompt },
        ],
      }),
    }
  );
  
  if (!aiResponse.ok) {
    const errorText = await aiResponse.text();
    return Response.json(
      { error: `OpenRouter error: ${errorText}` },
      { status: 500 }
    );
  }
  
  const aiData = await aiResponse.json();
  
  return Response.json({
    received: body,
    model: "nvidia/nemotron-3-nano-omni-30b-a3b-reasoning:free",
    aiRawResponse: aiData,
  });
}