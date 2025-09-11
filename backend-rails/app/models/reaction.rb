class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  REACTION_TYPES = %w[like love clap star idea target handshake sad angry hug muscle pray party].freeze
  REACTION_EMOJIS = {
    'like' => '👍',
    'love' => '❤️', 
    'clap' => '👏',
    'star' => '🌟',
    'idea' => '💡',
    'target' => '🎯',
    'handshake' => '🤝',
    'sad' => '😢',
    'angry' => '😠',
    'hug' => '🤗',
    'muscle' => '💪',
    'pray' => '🙏',
    'party' => '🎉'
  }.freeze
  
  validates :reaction_type, presence: true, inclusion: { in: REACTION_TYPES }
  validates :user_id, uniqueness: { scope: :post_id }
end