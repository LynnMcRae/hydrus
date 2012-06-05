class Hydrus::GenericObject < Dor::Item

  attr_accessor :apo_pid

  has_metadata(
    :name => "descMetadata",
    :type => Hydrus::DescMetadataDS,
    :label => 'Descriptive Metadata',
    :control_group => 'M')

  def object_type
      identityMetadata.objectType.first
  end

  def abstract
    descMetadata.abstract.first    
  end
  
  def title
    descMetadata.title.first
  end
  
  def apo
    @apo ||= (apo_pid ? get_fedora_item(apo_pid) : nil)
  end

  def apo_pid
    @apo_pid ||= admin_policy_object_ids.first
  end

  def get_fedora_item(pid)
    return ActiveFedora::Base.find(pid, :cast => true)
  end

  def discover_access
    return rightsMetadata.discover_access.first
  end

   def url
     "http://purl.stanford.edu/#{pid}"
   end

  def citations
    @citations ||= descMetadata.find_by_terms(:relatedItem).collect {|rel_node| 
      note = rel_node.at_css('note')      
      Hydrus::Citation.new(:text => note.content) if note
    }.compact    
  end
  
  def related_items
    @related_items ||= descMetadata.find_by_terms(:relatedItem).collect {|rel_node| 

      title_node = rel_node.at_css('titleInfo title')      
      url_node = rel_node.at_css('location url')

      if url_node
        url=url_node.content
        # link label is either the the title or the url itself if no title found
        link_label = title_node && !title_node.content.blank? ? title_node.content : url
        Hydrus::RelatedItem.new(:title => link_label, :url => url)
      end
    }.compact  
  end
  
end
