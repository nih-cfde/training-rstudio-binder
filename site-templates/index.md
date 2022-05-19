# Welcome to the {{site_name}}!

These are the training examples docs!


{% for issue in issues_list %}
{% if issue.is_frontpage %}

[Example: {{issue.title}}]({{issue.output_filename}})

{% endif %}
{% endfor %}

---

## [All examples](examples.md)

---

## [All categories](labels.md)
