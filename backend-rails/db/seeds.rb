# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Conteúdos educativos sobre TEA
contents = [
  {
    title: "Sinais Precoces do TEA",
    body: "Identificar os primeiros sinais do autismo pode fazer toda a diferença no desenvolvimento da criança. Alguns sinais incluem: dificuldade no contato visual, atraso na fala, comportamentos repetitivos e dificuldades na interação social.",
    category: "Diagnóstico",
    author: "Dr. Maria Silva",
    published_at: 1.day.ago
  },
  {
    title: "Terapia ABA: Como Funciona",
    body: "A Análise do Comportamento Aplicada (ABA) é uma das terapias mais eficazes para crianças com TEA. Ela utiliza técnicas baseadas em evidências para ensinar habilidades e reduzir comportamentos problemáticos.",
    category: "Terapias",
    author: "Psicóloga Ana Costa",
    published_at: 2.days.ago
  },
  {
    title: "Rotinas e Estrutura",
    body: "Estabelecer rotinas claras ajuda crianças com autismo a se sentirem mais seguras e organizadas. Use calendários visuais, horários estruturados e prepare a criança para mudanças.",
    category: "Comportamento",
    author: "Terapeuta João Santos",
    published_at: 3.days.ago
  },
  {
    title: "Inclusão Escolar",
    body: "A inclusão escolar é um direito de todas as crianças. Saiba como trabalhar com a escola para garantir que seu filho tenha o suporte necessário para aprender e se desenvolver.",
    category: "Educação",
    author: "Pedagoga Clara Lima",
    published_at: 4.days.ago
  }
]

contents.each do |content_attrs|
  Content.find_or_create_by(title: content_attrs[:title]) do |content|
    content.assign_attributes(content_attrs)
  end
end

# Recursos do Google Drive
resources = [
  {
    title: "Cartilha dos Direitos da Pessoa com Autismo",
    description: "Direitos fundamentais e legislação",
    resource_type: "guide",
    category: "Direitos",
    file_url: "https://drive.google.com/drive/folders/1WAolw5u1-G3S08tMFuwGZJXBRPM7qgoB"
  },
  {
    title: "Protocolo de Identificação Precoce",
    description: "Sinais de alerta e diagnóstico",
    resource_type: "checklist",
    category: "Diagnóstico",
    file_url: "https://drive.google.com/drive/folders/1WAolw5u1-G3S08tMFuwGZJXBRPM7qgoB"
  },
  {
    title: "Estratégias de Intervenção",
    description: "Técnicas terapêuticas e educacionais",
    resource_type: "manual",
    category: "Terapias",
    file_url: "https://drive.google.com/drive/folders/1WAolw5u1-G3S08tMFuwGZJXBRPM7qgoB"
  }
]

resources.each do |resource_attrs|
  Resource.find_or_create_by(title: resource_attrs[:title]) do |resource|
    resource.title = resource_attrs[:title]
    resource.description = resource_attrs[:description]
    resource.resource_type = resource_attrs[:resource_type]
    resource.category = resource_attrs[:category]
    resource.file_url = resource_attrs[:file_url]
  end
end

puts "#{Content.count} conteúdos e #{Resource.count} recursos criados!"