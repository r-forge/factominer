<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en   ">
<head>

  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>&lt;?php echo $group_name; ?&gt;</title>


  <link href="<?php echo $themeroot; ?>styles/estilo1.css" rel="stylesheet" type="text/css" />

</head>


<body>

<!-- R-Forge Logo -->
<table border="0" cellpadding="0" cellspacing="0" width="100%">

  <tbody>
    <tr>
      <td>
      <a href="/"><img src="<?php echo $themeroot; ?>/images/logo.png" alt="R-Forge Logo" border="0" /> </a> </td>
 </tr>

  </tbody>
</table>

<!-- get project title --><!-- own website starts here, the following may be changed as you like --><?php if ($handle=fopen('http://'.$domain.'/export/projtitl.php?group_name='.$group_name,'r')){
$contents = '';
while (!feof($handle)) {
$contents .= fread($handle, 8192);
}
fclose($handle);
echo $contents; } ?>


<!-- end of project description -->
<p> No content added. </p>

<p> The <strong>project summary page</strong> you can find <a href="http://<?php echo $domain; ?>/projects/<?php echo $group_name; ?>/"><strong>here</strong></a>. </p>

</body>
</html>
