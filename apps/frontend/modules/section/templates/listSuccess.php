<ul><?php foreach($sections as $s) if ($s->titre)
{ 
  echo '<li>';
  echo link_to($s->titre, '@section?id='.$s->id);
  echo ' ('.$s->nb_interventions.' interventions)';
  echo '</li>';
 } ?></ul>